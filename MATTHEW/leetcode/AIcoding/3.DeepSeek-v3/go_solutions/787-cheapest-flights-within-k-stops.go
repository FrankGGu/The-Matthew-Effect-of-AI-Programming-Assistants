func findCheapestPrice(n int, flights [][]int, src int, dst int, K int) int {
    const inf = 1 << 30
    dist := make([]int, n)
    for i := range dist {
        dist[i] = inf
    }
    dist[src] = 0

    for i := 0; i <= K; i++ {
        temp := make([]int, n)
        copy(temp, dist)
        for _, flight := range flights {
            u, v, w := flight[0], flight[1], flight[2]
            if dist[u] != inf && dist[u]+w < temp[v] {
                temp[v] = dist[u] + w
            }
        }
        dist = temp
    }

    if dist[dst] == inf {
        return -1
    }
    return dist[dst]
}