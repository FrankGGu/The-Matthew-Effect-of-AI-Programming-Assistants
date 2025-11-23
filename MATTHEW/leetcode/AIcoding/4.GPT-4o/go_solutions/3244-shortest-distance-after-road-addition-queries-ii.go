package main

import (
    "container/heap"
)

type Edge struct {
    to   int
    cost int
}

type MinHeap [][]int

func (h MinHeap) Len() int           { return len(h) }
func (h MinHeap) Less(i, j int) bool { return h[i][1] < h[j][1] }
func (h MinHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *MinHeap) Push(x interface{}) {
    *h = append(*h, x.([]int))
}

func (h *MinHeap) Pop() interface{} {
    old := *h
    n := len(old)
    x := old[n-1]
    *h = old[0 : n-1]
    return x
}

func shortestDistance(n int, edges [][]int, queries [][]int) []int {
    graph := make([][]Edge, n)
    for _, edge := range edges {
        graph[edge[0]] = append(graph[edge[0]], Edge{edge[1], edge[2]})
        graph[edge[1]] = append(graph[edge[1]], Edge{edge[0], edge[2]})
    }

    results := make([]int, len(queries))
    for i, query := range queries {
        results[i] = dijkstra(n, graph, query[0], query[1])
    }
    return results
}

func dijkstra(n int, graph [][]Edge, start int, end int) int {
    dist := make([]int, n)
    for i := range dist {
        dist[i] = 1e9
    }
    dist[start] = 0

    h := &MinHeap{{start, 0}}
    heap.Init(h)

    for h.Len() > 0 {
        u := heap.Pop(h).([]int)[0]

        if u == end {
            return dist[u]
        }

        for _, edge := range graph[u] {
            if dist[u]+edge.cost < dist[edge.to] {
                dist[edge.to] = dist[u] + edge.cost
                heap.Push(h, []int{edge.to, dist[edge.to]})
            }
        }
    }

    if dist[end] == 1e9 {
        return -1
    }
    return dist[end]
}