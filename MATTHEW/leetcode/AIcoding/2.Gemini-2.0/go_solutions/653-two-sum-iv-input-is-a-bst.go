func findTarget(root *TreeNode, k int) bool {
    nums := []int{}
    inorder(root, &nums)
    left, right := 0, len(nums)-1
    for left < right {
        sum := nums[left] + nums[right]
        if sum == k {
            return true
        } else if sum < k {
            left++
        } else {
            right--
        }
    }
    return false
}

func inorder(root *TreeNode, nums *[]int) {
    if root == nil {
        return
    }
    inorder(root.Left, nums)
    *nums = append(*nums, root.Val)
    inorder(root.Right, nums)
}