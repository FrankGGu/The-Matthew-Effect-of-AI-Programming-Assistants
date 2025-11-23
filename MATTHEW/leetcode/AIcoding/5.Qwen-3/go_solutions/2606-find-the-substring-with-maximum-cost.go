package main

func maxCost(arr []int, start int, end int) int {
    maxCost := 0
    currentCost := 0
    for i := start; i <= end; i++ {
        currentCost += arr[i]
        if currentCost > maxCost {
            maxCost = currentCost
        }
    }
    return maxCost
}