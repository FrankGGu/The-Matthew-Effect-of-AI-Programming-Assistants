func constructMaximumBinaryTree(nums []int) *TreeNode {
    if len(nums) == 0 {
        return nil
    }

    return build(nums, 0, len(nums)-1)
}

func build(nums []int, left, right int) *TreeNode {
    if left > right {
        return nil
    }

    maxVal := -1
    maxIdx := -1

    for i := left; i <= right; i++ {
        if nums[i] > maxVal {
            maxVal = nums[i]
            maxIdx = i
        }
    }

    root := &TreeNode{Val: maxVal}
    root.Left = build(nums, left, maxIdx-1)
    root.Right = build(nums, maxIdx+1, right)

    return root
}