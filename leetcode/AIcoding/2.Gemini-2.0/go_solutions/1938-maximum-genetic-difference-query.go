type Node struct {
	children [2]*Node
}

func insert(root *Node, num int) {
	curr := root
	for i := 17; i >= 0; i-- {
		bit := (num >> i) & 1
		if curr.children[bit] == nil {
			curr.children[bit] = &Node{}
		}
		curr = curr.children[bit]
	}
}

func findMaxXor(root *Node, num int) int {
	curr := root
	xor := 0
	for i := 17; i >= 0; i-- {
		bit := (num >> i) & 1
		if curr.children[1-bit] != nil {
			xor |= (1 << i)
			curr = curr.children[1-bit]
		} else {
			curr = curr.children[bit]
		}
	}
	return xor
}

func maxGeneticDifference(parents []int, queries [][]int) []int {
	n := len(parents)
	adj := make([][]int, n)
	rootVal := -1
	for i := 0; i < n; i++ {
		if parents[i] == -1 {
			rootVal = i
		} else {
			adj[parents[i]] = append(adj[parents[i]], i)
		}
	}

	queryMap := make(map[int][]int)
	for i, query := range queries {
		queryMap[query[0]] = append(queryMap[query[0]], i)
	}

	ans := make([]int, len(queries))
	trieRoot := &Node{}

	var dfs func(node int)
	dfs = func(node int) {
		insert(trieRoot, node)

		for _, queryIndex := range queryMap[node] {
			ans[queryIndex] = findMaxXor(trieRoot, queries[queryIndex][1])
		}

		for _, child := range adj[node] {
			dfs(child)
		}

		// Remove from trie (backtrack)
		curr := trieRoot
		path := []int{}
		num := node
		for i := 17; i >= 0; i-- {
			bit := (num >> i) & 1
			path = append(path, bit)
		}

		for i := 0; i < 18; i++ {
			bit := path[i]
			parent := curr
			curr = curr.children[bit]
			if i < 17 && len(adj[num]) == 0 && len(queryMap[num]) == 0{

			}else{
				parent.children[bit] = nil
				return
			}

		}
	}

	dfs(rootVal)
	return ans
}