import "math"

func findShortestCycle(n int, edges [][]int) int {
    adj := make([][]int, n)
    for _, edge := range edges {
        u, v := edge[0], edge[1]
        adj[u] = append(adj[u], v)
        adj[v] = append(adj[v], u)
    }

    minCycle := math.MaxInt32

    for i := 0; i < n; i++ {
        dist := make([]int, n)
        parent := make([]int, n)
        for j := 0; j < n; j++ {
            dist[j] = -1
            parent[j] = -1
        }

        q := []int{}

        q = append(q, i)
        dist[i] = 0

        head := 0
        for head < len(q) {
            u := q[head]
            head++

            for _, v := range adj[u] {
                if dist[v] == -1 {
                    dist[v] = dist[u] + 1
                    parent[v] = u
                    q = append(q, v)
                } else if v != parent[u] {
                    cycleLength := dist[u] + dist[v] + 1
                    if cycleLength < minCycle {
                        minCycle = cycleLength
                    }
                }
            }
        }
    }

    if minCycle == math.MaxInt32 {
        return -1
    }
    return minCycle
}