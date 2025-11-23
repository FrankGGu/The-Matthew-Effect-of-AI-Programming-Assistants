package main

func maxEmployees(n int, headID int, manager []int, informTime []int) int {
    graph := make(map[int][]int)
    for i := 0; i < n; i++ {
        if manager[i] != -1 {
            graph[manager[i]] = append(graph[manager[i]], i)
        }
    }

    var dfs func(int) int
    dfs = func(id int) int {
        maxTime := 0
        for _, child := range graph[id] {
            maxTime = max(maxTime, dfs(child))
        }
        return maxTime + informTime[id]
    }

    return dfs(headID)
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}