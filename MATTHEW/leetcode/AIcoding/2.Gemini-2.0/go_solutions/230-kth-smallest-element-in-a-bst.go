type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func kthSmallest(root *TreeNode, k int) int {
	var result int
	var count int

	var inorder func(node *TreeNode)
	inorder = func(node *TreeNode) {
		if node == nil {
			return
		}

		inorder(node.Left)
		count++
		if count == k {
			result = node.Val
			return
		}
		inorder(node.Right)
	}

	inorder(root)
	return result
}