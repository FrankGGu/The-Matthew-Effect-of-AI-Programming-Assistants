package main

type Node struct {
	Val   int
	Left  *Node
	Right *Node
}

func getDirections(root *TreeNode, target int, n *TreeNode) []byte {
	var path []byte

	var find func(*TreeNode, int) bool
	find = func(node *TreeNode, val int) bool {
		if node == nil {
			return false
		}
		if node.Val == val {
			return true
		}
		if find(node.Left, val) {
			path = append(path, 'L')
			return true
		}
		if find(node.Right, val) {
			path = append(path, 'R')
			return true
		}
		return false
	}

	find(root, target)

	var res []byte
	for i := len(path) - 1; i >= 0; i-- {
		res = append(res, 'U')
	}
	return res
}