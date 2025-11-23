package main

func twoCityScheduling(costs []int) int {
    sort.Slice(costs, func(i, j int) bool {
        return costs[i]-costs[i+1] < costs[j]-costs[j+1]
    })
    total := 0
    for i := 0; i < len(costs)/2; i++ {
        total += costs[i]
    }
    return total
}