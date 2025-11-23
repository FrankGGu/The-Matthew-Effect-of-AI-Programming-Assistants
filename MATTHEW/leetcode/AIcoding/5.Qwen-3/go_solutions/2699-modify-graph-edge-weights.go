package main

func modifyGraphEdgeWeights(n int, edges [][]int, source int, destination int, target int) []int {
    type Edge struct {
        to, weight int
    }
    graph := make([][]Edge, n)
    for _, e := range edges {
        u, v, w := e[0], e[1], e[2]
        graph[u] = append(graph[u], Edge{v, w})
        graph[v] = append(graph[v], Edge{u, w})
    }

    dist := func(start int) []int {
        d := make([]int, n)
        for i := range d {
            d[i] = 1 << 30
        }
        d[start] = 0
        h := &Heap{}
        h.Push(&Item{node: start, dist: 0})
        for h.Len() > 0 {
            item := h.Pop()
            if item.dist > d[item.node] {
                continue
            }
            for _, e := range graph[item.node] {
                if d[e.to] > d[item.node]+e.weight {
                    d[e.to] = d[item.node] + e.weight
                    h.Push(&Item{node: e.to, dist: d[e.to]})
                }
            }
        }
        return d
    }

    originalDist := dist(source)
    if originalDist[destination] > target {
        return nil
    }

    for i := range edges {
        u, v, w := edges[i][0], edges[i][1], edges[i][2]
        if w == 0 {
            edges[i][2] = target - originalDist[destination]
            graph[u] = append(graph[u], Edge{v, edges[i][2]})
            graph[v] = append(graph[v], Edge{u, edges[i][2]})
        }
    }

    newDist := dist(source)
    if newDist[destination] != target {
        return nil
    }

    return edges
}

type Item struct {
    node int
    dist int
}

type Heap []*Item

func (h Heap) Len() int           { return len(h) }
func (h Heap) Less(i, j int) bool { return h[i].dist < h[j].dist }
func (h Heap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *Heap) Push(x interface{}) {
    *h = append(*h, x.(*Item))
}

func (h *Heap) Pop() interface{} {
    old := *h
    n := len(old)
    x := old[n-1]
    *h = old[0 : n-1]
    return x
}