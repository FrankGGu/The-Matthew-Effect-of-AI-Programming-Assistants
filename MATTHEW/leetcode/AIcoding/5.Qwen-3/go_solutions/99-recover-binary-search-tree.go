package main


func recoverTree(root *TreeNode) {
	var first *TreeNode
	var second *TreeNode
	var prev *TreeNode

	var inorder func(*TreeNode)
	inorder = func(node *TreeNode) {
		if node == nil {
			return
		}
		inorder(node.Left)
		if prev != nil && prev.Val > node.Val {
			if first == nil {
				first = prev
			}
			second = node
		}
		prev = node
		inorder(node.Right)
	}

	inorder(root)

	first.Val, second.Val = second.Val, first.Val
}