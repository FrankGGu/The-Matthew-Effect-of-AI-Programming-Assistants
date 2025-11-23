func minCost(nums []int) int {
    n := len(nums)
    left, right := 0, n-1
    cost := 0

    for left < right {
        cost += abs(nums[left] - nums[right])
        left++
        right--
    }

    return cost
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}