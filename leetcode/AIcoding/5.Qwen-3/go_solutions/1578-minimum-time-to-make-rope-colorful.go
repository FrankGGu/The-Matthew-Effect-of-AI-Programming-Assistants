package main

func minCost(colors string, neededTime []int) int {
    total := 0
    for i := 1; i < len(colors); i++ {
        if colors[i] == colors[i-1] {
            total += neededTime[i]
            if neededTime[i] < neededTime[i-1] {
                total -= neededTime[i-1]
            }
        }
    }
    return total
}