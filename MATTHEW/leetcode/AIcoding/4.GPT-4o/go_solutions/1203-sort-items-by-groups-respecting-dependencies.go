package main

import (
    "fmt"
)

func sortItems(n int, m int, group []int, beforeItems [][]int) []int {
    const inf = 1 << 30
    groupMap := make(map[int]int)
    newGroup := 0

    for i := range group {
        if group[i] == -1 {
            group[i] = newGroup
            newGroup++
        }
        groupMap[group[i]]++
    }

    g := make([][]int, newGroup)
    itemGraph := make([][]int, n)
    groupGraph := make([][]int, newGroup)

    for i := 0; i < n; i++ {
        for _, j := range beforeItems[i] {
            itemGraph[j] = append(itemGraph[j], i)
            if group[i] != group[j] {
                groupGraph[group[j]] = append(groupGraph[group[j]], group[i])
            }
        }
    }

    itemOrder := topologicalSort(itemGraph)
    groupOrder := topologicalSort(groupGraph)

    if itemOrder == nil || groupOrder == nil {
        return nil
    }

    groupItems := make(map[int][]int)
    for _, item := range itemOrder {
        groupItems[group[item]] = append(groupItems[group[item]], item)
    }

    result := []int{}
    for _, g := range groupOrder {
        result = append(result, groupItems[g]...)
    }

    return result
}

func topologicalSort(graph [][]int) []int {
    inDegree := make([]int, len(graph))
    for _, edges := range graph {
        for _, v := range edges {
            inDegree[v]++
        }
    }

    queue := []int{}
    for i := range inDegree {
        if inDegree[i] == 0 {
            queue = append(queue, i)
        }
    }

    order := []int{}
    for len(queue) > 0 {
        node := queue[0]
        queue = queue[1:]
        order = append(order, node)

        for _, neighbor := range graph[node] {
            inDegree[neighbor]--
            if inDegree[neighbor] == 0 {
                queue = append(queue, neighbor)
            }
        }
    }

    if len(order) == len(graph) {
        return order
    }
    return nil
}

func main() {
    n := 8
    m := 2
    group := []int{-1, 0, 0, 1, 0, 1, -1, -1}
    beforeItems := [][]int{{}, {0}, {1}, {2}, {3}, {}, {5}, {}}
    result := sortItems(n, m, group, beforeItems)
    fmt.Println(result)
}