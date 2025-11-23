package main

import (
    "container/heap"
    "math"
)

type Edge struct {
    to     int
    weight int
}

type Graph struct {
    edges [][]Edge
}

func (g *Graph) addEdge(u, v, w int) {
    g.edges[u] = append(g.edges[u], Edge{to: v, weight: w})
}

func minWeightedSubgraph(n int, edges [][]int, limit int, start int, end int, required []int) int {
    g := &Graph{edges: make([][]Edge, n)}
    for _, e := range edges {
        g.addEdge(e[0], e[1], e[2])
        g.addEdge(e[1], e[0], e[2])
    }

    requiredSet := make(map[int]struct{})
    for _, r := range required {
        requiredSet[r] = struct{}{}
    }

    dist := make([]int, n)
    for i := range dist {
        dist[i] = math.MaxInt32
    }
    dist[start] = 0

    pq := &PriorityQueue{}
    heap.Push(pq, &Item{node: start, cost: 0})

    for pq.Len() > 0 {
        current := heap.Pop(pq).(*Item)
        u := current.node
        d := current.cost

        if d > dist[u] {
            continue
        }

        for _, edge := range g.edges[u] {
            if edge.weight > limit {
                continue
            }
            v := edge.to
            newDist := d + edge.weight
            if newDist < dist[v] {
                dist[v] = newDist
                heap.Push(pq, &Item{node: v, cost: newDist})
            }
        }
    }

    minCost := math.MaxInt32
    for _, r := range required {
        if dist[r] < minCost {
            minCost = dist[r]
        }
    }

    return minCost
}

type Item struct {
    node int
    cost int
}

type PriorityQueue []*Item

func (pq PriorityQueue) Len() int {
    return len(pq)
}

func (pq PriorityQueue) Less(i, j int) bool {
    return pq[i].cost < pq[j].cost
}

func (pq PriorityQueue) Swap(i, j int) {
    pq[i], pq[j] = pq[j], pq[i]
}

func (pq *PriorityQueue) Push(x interface{}) {
    *pq = append(*pq, x.(*Item))
}

func (pq *PriorityQueue) Pop() interface{} {
    old := *pq
    n := len(old)
    item := old[n-1]
    *pq = old[0 : n-1]
    return item
}