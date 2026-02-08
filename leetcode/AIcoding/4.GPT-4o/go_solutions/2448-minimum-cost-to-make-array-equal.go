func minCost(nums []int, cost []int, x int) int64 {
    n := len(nums)
    left, right := 1, int(1e9)
    res := int64(1e18)

    for left <= right {
        mid := left + (right-left)/2
        totalCost := int64(0)
        for i := 0; i < n; i++ {
            totalCost += int64(cost[i]) * int64(abs(nums[i]-mid))
        }
        if totalCost <= int64(x) {
            res = min(res, totalCost)
            right = mid - 1
        } else {
            left = mid + 1
        }
    }
    return res
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}

func min(a, b int64) int64 {
    if a < b {
        return a
    }
    return b
}