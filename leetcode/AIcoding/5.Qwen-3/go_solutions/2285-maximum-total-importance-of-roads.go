package main

func maximumImportance(n int, roads [][]int) int {
    importances := make([]int, n)
    for _, road := range roads {
        importances[road[0]]++
        importances[road[1]]++
    }
    sort.Ints(importances)
    result := 0
    for i := 0; i < n; i++ {
        result += importances[i] * (i + 1)
    }
    return result
}