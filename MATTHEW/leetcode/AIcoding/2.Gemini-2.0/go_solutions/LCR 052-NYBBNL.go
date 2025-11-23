type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func increasingBST(root *TreeNode) *TreeNode {
	var head *TreeNode
	var prev *TreeNode

	var inorder func(node *TreeNode)
	inorder = func(node *TreeNode) {
		if node == nil {
			return
		}

		inorder(node.Left)

		if head == nil {
			head = node
		} else {
			prev.Right = node
		}

		prev = node
		node.Left = nil

		inorder(node.Right)
	}

	inorder(root)

	if prev != nil {
		prev.Right = nil
	}

	return head
}