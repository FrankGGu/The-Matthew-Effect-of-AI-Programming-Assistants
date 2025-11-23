func recoverTree(root *TreeNode) {
	var first, middle, last, prev *TreeNode

	var inorder func(*TreeNode)
	inorder = func(node *TreeNode) {
		if node == nil {
			return
		}

		inorder(node.Left)

		if prev != nil && node.Val < prev.Val {
			if first == nil {
				first = prev
				middle = node
			} else {
				last = node
			}
		}
		prev = node

		inorder(node.Right)
	}

	inorder(root)

	if first != nil && last != nil {
		first.Val, last.Val = last.Val, first.Val
	} else if first != nil && middle != nil {
		first.Val, middle.Val = middle.Val, first.Val
	}
}