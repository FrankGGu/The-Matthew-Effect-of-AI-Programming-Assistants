func minCost(nums []int, x int) int64 {
    n := len(nums)
    minCosts := make([]int, n)
    copy(minCosts, nums)
    res := sum(minCosts)

    for k := 1; k < n; k++ {
        currentCosts := make([]int, n)
        for i := 0; i < n; i++ {
            currentCosts[i] = min(minCosts[i], nums[(i+k)%n])
        }
        total := sum(currentCosts) + k * x
        if total < res {
            res = total
        }
        minCosts = currentCosts
    }

    return int64(res)
}

func sum(arr []int) int {
    total := 0
    for _, num := range arr {
        total += num
    }
    return total
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}