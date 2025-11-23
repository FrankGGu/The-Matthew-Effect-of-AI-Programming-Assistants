func minimumCost(source string, target string, original []byte, changed []byte, cost []int) int64 {
    const inf = 1 << 60
    dist := [26][26]int64{}
    for i := 0; i < 26; i++ {
        for j := 0; j < 26; j++ {
            if i != j {
                dist[i][j] = inf
            }
        }
    }
    for i := 0; i < len(original); i++ {
        u := original[i] - 'a'
        v := changed[i] - 'a'
        if dist[u][v] > int64(cost[i]) {
            dist[u][v] = int64(cost[i])
        }
    }
    for k := 0; k < 26; k++ {
        for i := 0; i < 26; i++ {
            for j := 0; j < 26; j++ {
                if dist[i][k]+dist[k][j] < dist[i][j] {
                    dist[i][j] = dist[i][k] + dist[k][j]
                }
            }
        }
    }
    var res int64 = 0
    for i := 0; i < len(source); i++ {
        u := source[i] - 'a'
        v := target[i] - 'a'
        if u == v {
            continue
        }
        if dist[u][v] >= inf {
            return -1
        }
        res += dist[u][v]
    }
    return res
}