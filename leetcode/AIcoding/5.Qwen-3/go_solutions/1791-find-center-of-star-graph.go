package main

func findCenter(graph [][]int) int {
    if graph[0][0] == graph[1][0] || graph[0][0] == graph[1][1] {
        return graph[0][0]
    }
    return graph[0][1]
}