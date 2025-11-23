type Node struct {
	children map[string]*Node
	id       int
}

func deleteDuplicateFolder(paths [][]string) [][]string {
	root := &Node{children: make(map[string]*Node)}
	id := 1
	nodeMap := make(map[string][]string)
	idMap := make(map[int][]string)

	var buildTree func(path []string, node *Node)
	buildTree = func(path []string, node *Node) {
		if len(path) == 0 {
			return
		}
		name := path[0]
		if _, ok := node.children[name]; !ok {
			node.children[name] = &Node{children: make(map[string]*Node)}
		}
		buildTree(path[1:], node.children[name])
	}

	for _, path := range paths {
		buildTree(path, root)
	}

	var dfs func(node *Node) string
	dfs = func(node *Node) string {
		if len(node.children) == 0 {
			return "()"
		}
		s := "("
		keys := make([]string, 0, len(node.children))
		for k := range node.children {
			keys = append(keys, k)
		}
		sort.Strings(keys)
		for _, k := range keys {
			s += k + dfs(node.children[k])
		}
		s += ")"
		return s
	}

	var assignID func(node *Node)
	assignID = func(node *Node) {
		sig := dfs(node)
		if _, ok := nodeMap[sig]; !ok {
			node.id = id
			idMap[id] = []string{}
			id++
			nodeMap[sig] = []string{}
		} else {
			node.id = nodeMap[sig][0][0] - '0'
		}
		nodeMap[sig] = append(nodeMap[sig], string(rune(node.id+'0')))

		for _, child := range node.children {
			assignID(child)
		}
	}
	assignID(root)

	marked := make(map[int]bool)
	var markDuplicates func(node *Node, isRoot bool)
	markDuplicates = func(node *Node, isRoot bool) {
		if len(nodeMap[dfs(node)]) > 1 && !marked[node.id] && !isRoot {
			marked[node.id] = true
		}
		for _, child := range node.children {
			markDuplicates(child, false)
		}
	}
	markDuplicates(root, true)

	res := [][]string{}
	var getPaths func(node *Node, path []string)
	getPaths = func(node *Node, path []string) {
		if marked[node.id] {
			return
		}
		if len(path) > 0 {
			res = append(res, append([]string{}, path...))
		}
		keys := make([]string, 0, len(node.children))
		for k := range node.children {
			keys = append(keys, k)
		}
		sort.Strings(keys)
		for _, k := range keys {
			newPath := append(append([]string{}, path...), k)
			getPaths(node.children[k], newPath)
		}
	}
	getPaths(root, []string{})
	sort.Slice(res, func(i, j int) bool {
		if len(res[i]) != len(res[j]) {
			return len(res[i]) < len(res[j])
		}
		for k := 0; k < len(res[i]); k++ {
			if res[i][k] != res[j][k] {
				return res[i][k] < res[j][k]
			}
		}
		return false
	})
	return res
}

import (
	"sort"
)