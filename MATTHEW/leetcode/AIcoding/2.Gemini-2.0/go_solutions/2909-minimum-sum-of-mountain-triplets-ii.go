func minimumSum(nums []int) int {
    n := len(nums)
    leftMin := make([]int, n)
    rightMin := make([]int, n)
    leftMin[0] = nums[0]
    for i := 1; i < n; i++ {
        leftMin[i] = min(leftMin[i-1], nums[i])
    }
    rightMin[n-1] = nums[n-1]
    for i := n - 2; i >= 0; i-- {
        rightMin[i] = min(rightMin[i+1], nums[i])
    }
    ans := int(1e9 + 7)
    for i := 1; i < n-1; i++ {
        if nums[i] > leftMin[i-1] && nums[i] > rightMin[i+1] {
            ans = min(ans, leftMin[i-1]+nums[i]+rightMin[i+1])
        }
    }
    if ans == int(1e9+7) {
        return -1
    }
    return ans
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}