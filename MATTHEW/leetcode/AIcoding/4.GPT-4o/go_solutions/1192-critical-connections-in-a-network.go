package main

import "fmt"

var time int
var result [][]int

func criticalConnections(n int, connections [][]int) [][]int {
	graph := make([][]int, n)
	for _, conn := range connections {
		graph[conn[0]] = append(graph[conn[0]], conn[1])
		graph[conn[1]] = append(graph[conn[1]], conn[0])
	}

	disc := make([]int, n)
	low := make([]int, n)
	visited := make([]bool, n)

	result = [][]int{}
	time = 0
	for i := 0; i < n; i++ {
		if !visited[i] {
			dfs(i, -1, disc, low, visited, graph)
		}
	}
	return result
}

func dfs(u, parent int, disc, low []int, visited []bool, graph [][]int) {
	visited[u] = true
	time++
	disc[u] = time
	low[u] = time

	for _, v := range graph[u] {
		if v == parent {
			continue
		}
		if !visited[v] {
			dfs(v, u, disc, low, visited, graph)
			low[u] = min(low[u], low[v])
			if low[v] > disc[u] {
				result = append(result, []int{u, v})
			}
		} else {
			low[u] = min(low[u], disc[v])
		}
	}
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}

func main() {
	n := 4
	connections := [][]int{{0, 1}, {1, 2}, {2, 0}, {1, 3}}
	fmt.Println(criticalConnections(n, connections))
}