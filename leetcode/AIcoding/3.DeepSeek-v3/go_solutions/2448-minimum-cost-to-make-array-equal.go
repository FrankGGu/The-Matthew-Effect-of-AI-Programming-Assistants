func minCost(nums []int, cost []int) int64 {
    n := len(nums)
    type pair struct {
        num, cost int
    }
    pairs := make([]pair, n)
    for i := 0; i < n; i++ {
        pairs[i] = pair{nums[i], cost[i]}
    }
    sort.Slice(pairs, func(i, j int) bool {
        return pairs[i].num < pairs[j].num
    })

    prefixCost := make([]int64, n+1)
    for i := 0; i < n; i++ {
        prefixCost[i+1] = prefixCost[i] + int64(pairs[i].cost)
    }

    totalCost := int64(0)
    for i := 1; i < n; i++ {
        totalCost += int64(pairs[i].cost) * int64(pairs[i].num - pairs[0].num)
    }

    minCost := totalCost
    for i := 1; i < n; i++ {
        gap := pairs[i].num - pairs[i-1].num
        totalCost += prefixCost[i] * int64(gap)
        totalCost -= (prefixCost[n] - prefixCost[i]) * int64(gap)
        if totalCost < minCost {
            minCost = totalCost
        }
    }

    return minCost
}