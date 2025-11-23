type Item struct {
    node, time int
}

func secondMinimum(n int, edges [][]int, time int, change int) int {
    graph := make([][]int, n)
    for _, edge := range edges {
        a, b := edge[0]-1, edge[1]-1
        graph[a] = append(graph[a], b)
        graph[b] = append(graph[b], a)
    }

    dist := make([][2]int, n)
    for i := range dist {
        dist[i] = [2]int{int(1e9), int(1e9)}
    }
    dist[0][0] = 0

    pq := &[]Item{{0, 0}}
    for len(*pq) > 0 {
        curr := (*pq)[0]
        *pq = (*pq)[1:]

        for _, neighbor := range graph[curr.node] {
            nextTime := curr.time + time
            if nextTime%change != 0 {
                nextTime += change - nextTime%change
            }
            nextTime += time

            if nextTime < dist[neighbor][0] {
                dist[neighbor][1] = dist[neighbor][0]
                dist[neighbor][0] = nextTime
                *pq = append(*pq, Item{neighbor, nextTime})
            } else if nextTime < dist[neighbor][1] && nextTime > dist[neighbor][0] {
                dist[neighbor][1] = nextTime
                *pq = append(*pq, Item{neighbor, nextTime})
            }
        }
        sort.Slice(*pq, func(i, j int) bool {
            return (*pq)[i].time < (*pq)[j].time
        })
    }

    if dist[n-1][1] == int(1e9) {
        return -1
    }
    return dist[n-1][1]
}