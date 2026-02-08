package main

func minCost(nums []int, cost []int) int {
    type Pair struct {
        num int
        cos int
    }
    pairs := make([]Pair, len(nums))
    for i := range nums {
        pairs[i] = Pair{nums[i], cost[i]}
    }
    sort.Slice(pairs, func(i, j int) bool {
        return pairs[i].num < pairs[j].num
    })
    totalCost := 0
    for _, p := range pairs {
        totalCost += p.cos
    }
    medianIndex := 0
    currentSum := 0
    for i, p := range pairs {
        currentSum += p.cos
        if currentSum * 2 >= totalCost {
            medianIndex = i
            break
        }
    }
    median := pairs[medianIndex].num
    res := 0
    for i := range pairs {
        res += abs(pairs[i].num - median) * pairs[i].cos
    }
    return res
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}