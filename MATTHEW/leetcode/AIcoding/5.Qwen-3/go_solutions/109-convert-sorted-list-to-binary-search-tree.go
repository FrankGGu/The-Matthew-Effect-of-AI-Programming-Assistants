package main



func sortedListToBST(head *ListNode) *TreeNode {
	if head == nil {
		return nil
	}
	return buildTree(head, nil)
}

func buildTree(left *ListNode, right *ListNode) *TreeNode {
	if left == right {
		return nil
	}
	fast, slow := left, left
	for fast != right && fast.Next != right {
		fast = fast.Next.Next
		slow = slow.Next
	}
	root := &TreeNode{Val: slow.Val}
	root.Left = buildTree(left, slow)
	root.Right = buildTree(slow.Next, right)
	return root
}