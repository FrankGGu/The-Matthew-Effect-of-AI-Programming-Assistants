func findMinCost(nums []int) int {
    n := len(nums)
    result := 0
    cost := make([]int, n)

    for i := 0; i < n; i++ {
        cost[i] = nums[i]
    }

    for i := 1; i < n; i++ {
        if nums[i] < nums[i-1] {
            result += nums[i-1] - nums[i]
            nums[i] = nums[i-1]
        }
    }

    return result
}