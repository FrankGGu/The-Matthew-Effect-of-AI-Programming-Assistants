import "container/heap"

type Edge struct {
    v int
    w int
}

type Node struct {
    id    int
    dist  int
}

type PriorityQueue []Node

func (pq PriorityQueue) Len() int { return len(pq) }

func (pq PriorityQueue) Less(i, j int) bool {
    return pq[i].dist < pq[j].dist
}

func (pq PriorityQueue) Swap(i, j int) {
    pq[i], pq[j] = pq[j], pq[i]
}

func (pq *PriorityQueue) Push(x interface{}) {
    item := x.(Node)
    *pq = append(*pq, item)
}

func (pq *PriorityQueue) Pop() interface{} {
    old := *pq
    n := len(old)
    item := old[n-1]
    *pq = old[0 : n-1]
    return item
}

func reachableNodes(edges [][]int, maxMoves int, n int) int {
    adj := make([][]Edge, n)
    for _, edge := range edges {
        u, v, w := edge[0], edge[1], edge[2]
        adj[u] = append(adj[u], Edge{v, w + 1})
        adj[v] = append(adj[v], Edge{u, w + 1})
    }

    dist := make([]int, n)
    for i := range dist {
        dist[i] = 1 << 30
    }
    dist[0] = 0

    pq := &PriorityQueue{{0, 0}}
    heap.Init(pq)

    visited := make(map[int]bool)

    for pq.Len() > 0 {
        node := heap.Pop(pq).(Node)
        u := node.id

        if visited[u] {
            continue
        }
        visited[u] = true

        for _, edge := range adj[u] {
            v, w := edge.v, edge.w
            if dist[u]+w < dist[v] {
                dist[v] = dist[u] + w
                heap.Push(pq, Node{v, dist[v]})
            }
        }
    }

    ans := 0
    for i := 0; i < n; i++ {
        if dist[i] <= maxMoves {
            ans++
        }
    }

    for _, edge := range edges {
        u, v, w := edge[0], edge[1], edge[2]
        a := max(0, maxMoves-dist[u])
        b := max(0, maxMoves-dist[v])
        ans += min(w, a+b)
    }

    return ans
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}