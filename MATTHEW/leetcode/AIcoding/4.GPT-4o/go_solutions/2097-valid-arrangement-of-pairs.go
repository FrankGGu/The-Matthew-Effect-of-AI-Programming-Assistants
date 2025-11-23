package main

import (
	"fmt"
	"sort"
)

func validArrangement(pairs [][]int) [][]int {
	graph := make(map[int][]int)
	for _, pair := range pairs {
		graph[pair[0]] = append(graph[pair[0]], pair[1])
	}

	for k := range graph {
		sort.Ints(graph[k])
	}

	result := [][]int{}
	var dfs func(int)
	dfs = func(node int) {
		for len(graph[node]) > 0 {
			next := graph[node][0]
			graph[node] = graph[node][1:]
			dfs(next)
		}
		result = append(result, []int{node, 0})
	}
	dfs(pairs[0][0])

	for i := len(result) - 1; i >= 0; i-- {
		result[i][1] = result[i][0]
		if i < len(result)-1 {
			result[i][0] = result[i+1][1]
		}
	}

	return result[1:]
}

func main() {
	pairs := [][]int{{5, 1}, {4, 5}, {11, 9}, {9, 4}}
	result := validArrangement(pairs)
	fmt.Println(result)
}