func maximalPathQuality(values []int, edges [][]int, maxTime int) int {
    n := len(values)
    adj := make([][][]int, n)
    for _, e := range edges {
        u, v, t := e[0], e[1], e[2]
        adj[u] = append(adj[u], []int{v, t})
        adj[v] = append(adj[v], []int{u, t})
    }

    maxQuality := 0
    visited := make([]int, n)
    visited[0] = 1

    var dfs func(int, int, int)
    dfs = func(u, time, quality int) {
        if u == 0 {
            if quality > maxQuality {
                maxQuality = quality
            }
        }

        for _, e := range adj[u] {
            v, t := e[0], e[1]
            if time + t > maxTime {
                continue
            }
            if visited[v] == 0 {
                quality += values[v]
            }
            visited[v]++
            dfs(v, time + t, quality)
            visited[v]--
            if visited[v] == 0 {
                quality -= values[v]
            }
        }
    }

    dfs(0, 0, values[0])
    return maxQuality
}