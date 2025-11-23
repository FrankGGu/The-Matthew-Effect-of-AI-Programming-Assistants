type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func increasingBST(root *TreeNode) *TreeNode {
	var head *TreeNode
	var prev *TreeNode

	var inorder func(*TreeNode)
	inorder = func(node *TreeNode) {
		if node == nil {
			return
		}

		inorder(node.Left)

		if prev == nil {
			head = node
		} else {
			prev.Right = node
		}

		node.Left = nil
		prev = node

		inorder(node.Right)
	}

	inorder(root)
	return head
}