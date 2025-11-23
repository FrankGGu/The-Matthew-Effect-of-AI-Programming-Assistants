package main

func minCostToVisitAllPoints(n int, paths [][]int) int {
    cost := 0
    for i := 0; i < n-1; i++ {
        x1, y1 := paths[i][0], paths[i][1]
        x2, y2 := paths[i+1][0], paths[i+1][1]
        cost += abs(x2-x1) + abs(y2-y1)
    }
    return cost
}

func abs(a int) int {
    if a < 0 {
        return -a
    }
    return a
}