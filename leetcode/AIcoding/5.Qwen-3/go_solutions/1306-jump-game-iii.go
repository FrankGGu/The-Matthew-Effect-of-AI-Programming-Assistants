package main

func canReach(arr []int, start int) bool {
    visited := make(map[int]bool)
    return dfs(arr, start, visited)
}

func dfs(arr []int, index int, visited map[int]bool) bool {
    if index < 0 || index >= len(arr) {
        return false
    }
    if visited[index] {
        return false
    }
    if arr[index] == 0 {
        return true
    }
    visited[index] = true
    return dfs(arr, index+arr[index], visited) || dfs(arr, index-arr[index], visited)
}