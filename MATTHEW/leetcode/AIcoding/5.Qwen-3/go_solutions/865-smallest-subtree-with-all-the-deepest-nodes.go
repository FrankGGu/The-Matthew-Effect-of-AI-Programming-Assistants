package main


func subtreeWithAllDeepest(root *TreeNode) *TreeNode {
	if root == nil {
		return nil
	}
	left := depth(root.Left)
	right := depth(root.Right)
	if left == right {
		return root
	} else if left > right {
		return subtreeWithAllDeepest(root.Left)
	} else {
		return subtreeWithAllDeepest(root.Right)
	}
}

func depth(node *TreeNode) int {
	if node == nil {
		return 0
	}
	return 1 + max(depth(node.Left), depth(node.Right))
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}