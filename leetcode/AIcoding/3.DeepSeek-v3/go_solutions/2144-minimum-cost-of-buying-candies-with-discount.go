func minimumCost(cost []int) int {
    sort.Sort(sort.Reverse(sort.IntSlice(cost)))
    total := 0
    for i := 0; i < len(cost); i++ {
        if i%3 != 2 {
            total += cost[i]
        }
    }
    return total
}