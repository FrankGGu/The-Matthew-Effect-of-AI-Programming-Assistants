import (
    "container/heap"
)

type Edge struct {
    node, weight int
}

type PriorityQueue []*Edge

func (pq PriorityQueue) Len() int           { return len(pq) }
func (pq PriorityQueue) Less(i, j int) bool { return pq[i].weight < pq[j].weight }
func (pq PriorityQueue) Swap(i, j int)      { pq[i], pq[j] = pq[j], pq[i] }

func (pq *PriorityQueue) Push(x interface{}) {
    *pq = append(*pq, x.(*Edge))
}

func (pq *PriorityQueue) Pop() interface{} {
    old := *pq
    n := len(old)
    item := old[n-1]
    *pq = old[:n-1]
    return item
}

func countRestrictedPaths(n int, edges [][]int) int {
    const mod = 1e9 + 7
    adj := make([][]Edge, n+1)
    for _, e := range edges {
        u, v, w := e[0], e[1], e[2]
        adj[u] = append(adj[u], Edge{v, w})
        adj[v] = append(adj[v], Edge{u, w})
    }

    dist := make([]int, n+1)
    for i := range dist {
        dist[i] = 1 << 31 - 1
    }
    dist[n] = 0
    pq := make(PriorityQueue, 0)
    heap.Push(&pq, &Edge{n, 0})

    for len(pq) > 0 {
        current := heap.Pop(&pq).(*Edge)
        u := current.node
        if current.weight > dist[u] {
            continue
        }
        for _, edge := range adj[u] {
            v, w := edge.node, edge.weight
            if dist[v] > dist[u]+w {
                dist[v] = dist[u] + w
                heap.Push(&pq, &Edge{v, dist[v]})
            }
        }
    }

    memo := make([]int, n+1)
    for i := range memo {
        memo[i] = -1
    }
    var dfs func(int) int
    dfs = func(u int) int {
        if u == n {
            return 1
        }
        if memo[u] != -1 {
            return memo[u]
        }
        res := 0
        for _, edge := range adj[u] {
            v := edge.node
            if dist[u] > dist[v] {
                res = (res + dfs(v)) % mod
            }
        }
        memo[u] = res
        return res
    }
    return dfs(1)
}