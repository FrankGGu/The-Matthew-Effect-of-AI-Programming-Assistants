func countPairsOfConnectableServers(edges [][]int, signalSpeed int) []int {
    n := len(edges) + 1
    adj := make([][][]int, n)
    for _, edge := range edges {
        u, v, w := edge[0], edge[1], edge[2]
        adj[u] = append(adj[u], []int{v, w})
        adj[v] = append(adj[v], []int{u, w})
    }

    res := make([]int, n)
    for c := 0; c < n; c++ {
        var counts []int
        for _, neighbor := range adj[c] {
            v, w := neighbor[0], neighbor[1]
            cnt := 0
            stack := [][]int{{v, w}}
            for len(stack) > 0 {
                node, dist := stack[len(stack)-1][0], stack[len(stack)-1][1]
                stack = stack[:len(stack)-1]
                if dist % signalSpeed == 0 {
                    cnt++
                }
                for _, next := range adj[node] {
                    if next[0] != c && next[0] != node {
                        stack = append(stack, []int{next[0], dist + next[1]})
                    }
                }
            }
            counts = append(counts, cnt)
        }
        total := 0
        sum := 0
        for _, cnt := range counts {
            total += sum * cnt
            sum += cnt
        }
        res[c] = total
    }
    return res
}