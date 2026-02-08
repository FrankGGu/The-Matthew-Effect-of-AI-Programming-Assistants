package main


func constructMaximumBinaryTree(nums []int) *TreeNode {
	if len(nums) == 0 {
		return nil
	}
	maxVal := nums[0]
	maxIndex := 0
	for i, num := range nums {
		if num > maxVal {
			maxVal = num
			maxIndex = i
		}
	}
	root := &TreeNode{Val: maxVal}
	root.Left = constructMaximumBinaryTree(nums[:maxIndex])
	root.Right = constructMaximumBinaryTree(nums[maxIndex+1:])
	return root
}