package main

func minimumCost(cost []int) int {
    sort.Ints(cost)
    total := 0
    for i := len(cost) - 1; i >= 0; i -= 2 {
        total += cost[i]
        if i-1 >= 0 {
            total += cost[i-1]
        }
    }
    return total
}