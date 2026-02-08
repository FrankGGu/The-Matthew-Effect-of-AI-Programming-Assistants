package main

import "fmt"

func canFinish(n int, prerequisites [][]int, queries [][]int) []bool {
    graph := make([][]int, n)
    indegree := make([]int, n)

    for _, pre := range prerequisites {
        graph[pre[1]] = append(graph[pre[1]], pre[0])
        indegree[pre[0]]++
    }

    order := make([]int, 0)
    for i := 0; i < n; i++ {
        if indegree[i] == 0 {
            order = append(order, i)
        }
    }

    for i := 0; i < len(order); i++ {
        curr := order[i]
        for _, neighbor := range graph[curr] {
            indegree[neighbor]--
            if indegree[neighbor] == 0 {
                order = append(order, neighbor)
            }
        }
    }

    reachable := make(map[int]map[int]bool)
    for _, node := range order {
        reachable[node] = make(map[int]bool)
        reachable[node][node] = true
        for _, neighbor := range graph[node] {
            for k := range reachable[node] {
                reachable[node][neighbor] = true
                reachable[k][neighbor] = true
            }
        }
    }

    result := make([]bool, len(queries))
    for i, query := range queries {
        result[i] = reachable[query[1]][query[0]]
    }

    return result
}

func main() {
    n := 2
    prerequisites := [][]int{{1, 0}}
    queries := [][]int{{0, 1}, {1, 0}}
    fmt.Println(canFinish(n, prerequisites, queries)) // Output: [false true]
}