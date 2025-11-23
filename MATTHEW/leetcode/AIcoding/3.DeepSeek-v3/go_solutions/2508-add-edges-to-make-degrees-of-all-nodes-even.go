func isPossible(n int, edges [][]int) bool {
    adj := make(map[int]map[int]bool)
    for i := 1; i <= n; i++ {
        adj[i] = make(map[int]bool)
    }
    for _, e := range edges {
        u, v := e[0], e[1]
        adj[u][v] = true
        adj[v][u] = true
    }

    odds := []int{}
    for i := 1; i <= n; i++ {
        if len(adj[i])%2 != 0 {
            odds = append(odds, i)
        }
    }

    if len(odds) == 0 {
        return true
    }
    if len(odds) != 2 && len(odds) != 4 {
        return false
    }

    if len(odds) == 2 {
        a, b := odds[0], odds[1]
        if !adj[a][b] {
            return true
        }
        for c := 1; c <= n; c++ {
            if c != a && c != b && !adj[a][c] && !adj[b][c] {
                return true
            }
        }
        return false
    } else {
        a, b, c, d := odds[0], odds[1], odds[2], odds[3]
        if (!adj[a][b] && !adj[c][d]) || (!adj[a][c] && !adj[b][d]) || (!adj[a][d] && !adj[b][c]) {
            return true
        }
        return false
    }
}