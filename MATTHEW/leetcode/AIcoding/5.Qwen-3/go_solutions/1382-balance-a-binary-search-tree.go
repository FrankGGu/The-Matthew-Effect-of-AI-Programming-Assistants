package main


func balanceBST(root *TreeNode) *TreeNode {
	var nums []int
	inorder(root, &nums)
	return buildTree(nums, 0, len(nums)-1)
}

func inorder(node *TreeNode, nums *[]int) {
	if node == nil {
		return
	}
	inorder(node.Left, nums)
	*nums = append(*nums, node.Val)
	inorder(node.Right, nums)
}

func buildTree(nums []int, left, right int) *TreeNode {
	if left > right {
		return nil
	}
	mid := left + (right-left)/2
	node := &TreeNode{Val: nums[mid]}
	node.Left = buildTree(nums, left, mid-1)
	node.Right = buildTree(nums, mid+1, right)
	return node
}