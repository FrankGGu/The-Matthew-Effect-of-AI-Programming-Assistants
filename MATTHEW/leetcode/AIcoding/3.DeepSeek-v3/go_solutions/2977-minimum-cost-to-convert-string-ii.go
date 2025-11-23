func minimumCost(source string, target string, original []string, changed []string, cost []int) int64 {
    const inf = 1 << 60
    dist := make(map[string]map[string]int64)
    for i := 0; i < len(original); i++ {
        o := original[i]
        c := changed[i]
        if _, ok := dist[o]; !ok {
            dist[o] = make(map[string]int64)
        }
        if val, ok := dist[o][c]; !ok || int64(cost[i]) < val {
            dist[o][c] = int64(cost[i])
        }
    }

    for k := range dist {
        for i := range dist {
            for j := range dist {
                if _, ok := dist[i][k]; !ok {
                    continue
                }
                if _, ok := dist[k][j]; !ok {
                    continue
                }
                if _, ok := dist[i][j]; !ok || dist[i][k]+dist[k][j] < dist[i][j] {
                    dist[i][j] = dist[i][k] + dist[k][j]
                }
            }
        }
    }

    n := len(source)
    dp := make([]int64, n+1)
    for i := range dp {
        dp[i] = inf
    }
    dp[0] = 0

    for i := 0; i < n; i++ {
        if dp[i] == inf {
            continue
        }
        if source[i] == target[i] {
            if dp[i+1] > dp[i] {
                dp[i+1] = dp[i]
            }
        }
        for l := 1; i+l <= n; l++ {
            s := source[i : i+l]
            t := target[i : i+l]
            if s == t {
                if dp[i+l] > dp[i] {
                    dp[i+l] = dp[i]
                }
                continue
            }
            if _, ok := dist[s]; !ok {
                continue
            }
            if val, ok := dist[s][t]; ok {
                if dp[i+l] > dp[i]+val {
                    dp[i+l] = dp[i] + val
                }
            }
        }
    }

    if dp[n] == inf {
        return -1
    }
    return dp[n]
}