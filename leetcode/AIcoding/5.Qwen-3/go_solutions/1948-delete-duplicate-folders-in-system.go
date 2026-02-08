package main

type TreeNode struct {
	Val       int
	Children  []*TreeNode
}

func deleteDuplicateFolders(root *TreeNode) *TreeNode {
	m := make(map[string]*TreeNode)
	var serialize func(*TreeNode) string
	serialize = func(node *TreeNode) string {
		if node == nil {
			return ""
		}
		var sb []string
		for _, child := range node.Children {
			sb = append(sb, serialize(child))
		}
		s := "(" + strings.Join(sb, "") + ")"
		m[s] = node
		return s
	}
	serialize(root)

	var remove func(*TreeNode) *TreeNode
	remove = func(node *TreeNode) *TreeNode {
		if node == nil {
			return nil
		}
		newChildren := make([]*TreeNode, 0)
		for _, child := range node.Children {
			nc := remove(child)
			if nc != nil {
				newChildren = append(newChildren, nc)
			}
		}
		if len(newChildren) == 0 {
			return nil
		}
		node.Children = newChildren
		return node
	}

	result := remove(root)
	return result
}