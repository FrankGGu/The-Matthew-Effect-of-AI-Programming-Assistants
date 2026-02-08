package main

func numOfMinutes(n int, headID int, manager []int, informTime []int) int {
    memo := make(map[int]int)
    var dfs func(int) int
    dfs = func(id int) int {
        if time, ok := memo[id]; ok {
            return time
        }
        if manager[id] == -1 {
            return 0
        }
        time := dfs(manager[id]) + informTime[manager[id]]
        memo[id] = time
        return time
    }
    maxTime := 0
    for i := 0; i < n; i++ {
        if manager[i] != -1 {
            current := dfs(i)
            if current > maxTime {
                maxTime = current
            }
        }
    }
    return maxTime
}