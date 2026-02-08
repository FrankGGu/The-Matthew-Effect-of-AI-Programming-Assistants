var firstNode, secondNode, prevNode *TreeNode

func recoverTree(root *TreeNode) {
	firstNode = nil
	secondNode = nil
	prevNode = nil

	inorderTraversal(root)

	if firstNode != nil && secondNode != nil {
		firstNode.Val, secondNode.Val = secondNode.Val, firstNode.Val
	}
}

func inorderTraversal(node *TreeNode) {
	if node == nil {
		return
	}

	inorderTraversal(node.Left)

	if prevNode != nil && prevNode.Val > node.Val {
		if firstNode == nil {
			firstNode = prevNode
		}
		secondNode = node
	}
	prevNode = node

	inorderTraversal(node.Right)
}