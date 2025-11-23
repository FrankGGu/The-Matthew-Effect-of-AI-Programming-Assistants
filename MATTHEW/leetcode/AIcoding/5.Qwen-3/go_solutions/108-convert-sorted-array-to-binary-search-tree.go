package main


func sortedArrayToBST(nums []int) *TreeNode {
	if len(nums) == 0 {
		return nil
	}
	return buildTree(nums, 0, len(nums)-1)
}

func buildTree(nums []int, left, right int) *TreeNode {
	if left > right {
		return nil
	}
	mid := left + (right-left)/2
	node := &TreeNode{
		Val:   nums[mid],
		Left:  buildTree(nums, left, mid-1),
		Right: buildTree(nums, mid+1, right),
	}
	return node
}