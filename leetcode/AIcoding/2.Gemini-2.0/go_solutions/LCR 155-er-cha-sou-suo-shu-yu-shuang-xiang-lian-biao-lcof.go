type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func treeToDoublyList(root *TreeNode) *TreeNode {
	if root == nil {
		return nil
	}

	var head, prev *TreeNode

	var inorder func(node *TreeNode)
	inorder = func(node *TreeNode) {
		if node == nil {
			return
		}

		inorder(node.Left)

		if prev != nil {
			prev.Right = node
			node.Left = prev
		} else {
			head = node
		}
		prev = node

		inorder(node.Right)
	}

	inorder(root)

	head.Left = prev
	prev.Right = head

	return head
}