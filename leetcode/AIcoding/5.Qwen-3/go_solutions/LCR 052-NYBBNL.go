package main


func increasingBST(root *TreeNode) *ListNode {
	var dummy *ListNode = &ListNode{}
	var current *ListNode = dummy

	var traverse func(*TreeNode)
	traverse = func(node *TreeNode) {
		if node == nil {
			return
		}
		traverse(node.Left)
		current.Next = &ListNode{Val: node.Val}
		current = current.Next
		traverse(node.Right)
	}

	traverse(root)
	return dummy.Next
}