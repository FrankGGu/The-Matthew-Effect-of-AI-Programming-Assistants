package main

type Graph struct {
    adj map[int][]int
    weight map[int]map[int]int
}

func Constructor(n int, edges [][]int) Graph {
    g := Graph{
        adj: make(map[int][]int),
        weight: make(map[int]map[int]int),
    }
    for _, edge := range edges {
        u, v, w := edge[0], edge[1], edge[2]
        if g.adj[u] == nil {
            g.adj[u] = []int{}
        }
        g.adj[u] = append(g.adj[u], v)
        if g.weight[u] == nil {
            g.weight[u] = make(map[int]int)
        }
        g.weight[u][v] = w
    }
    return g
}

func (this *Graph) AddEdge(edge []int) {
    u, v, w := edge[0], edge[1], edge[2]
    if this.adj[u] == nil {
        this.adj[u] = []int{}
    }
    this.adj[u] = append(this.adj[u], v)
    if this.weight[u] == nil {
        this.weight[u] = make(map[int]int)
    }
    this.weight[u][v] = w
}

func (this *Graph) ShortestPath(node1 int, node2 int) int {
    dist := make(map[int]int)
    for k := range this.adj {
        dist[k] = 1 << 31
    }
    dist[node1] = 0
    visited := make(map[int]bool)
    heap := &PriorityQueue{}
    heap.Push(&Item{value: node1, priority: 0})
    for heap.Len() > 0 {
        item := heap.Pop().(*Item)
        current := item.value
        if visited[current] {
            continue
        }
        visited[current] = true
        if current == node2 {
            break
        }
        for _, neighbor := range this.adj[current] {
            newDist := dist[current] + this.weight[current][neighbor]
            if newDist < dist[neighbor] {
                dist[neighbor] = newDist
                heap.Push(&Item{value: neighbor, priority: newDist})
            }
        }
    }
    if dist[node2] == 1<<31 {
        return -1
    }
    return dist[node2]
}

type Item struct {
    value    int
    priority int
}

type PriorityQueue []*Item

func (pq PriorityQueue) Len() int { return len(pq) }

func (pq PriorityQueue) Less(i, j int) bool {
    return pq[i].priority < pq[j].priority
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
    old[n-1] = nil
    *pq = old[0 : n-1]
    return item
}