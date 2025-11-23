package main


func constructMaximumBinaryTree(nums []int) *TreeNode {
	if len(nums) == 0 {
		return nil
	}
	maxVal := nums[0]
	index := 0
	for i, num := range nums {
		if num > maxVal {
			maxVal = num
			index = i
		}
	}
	node := &TreeNode{Val: maxVal}
	node.Left = constructMaximumBinaryTree(nums[:index])
	node.Right = constructMaximumBinaryTree(nums[index+1:])
	return node
}