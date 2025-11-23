type Edge struct {
    to     int
    weight int
}

func findTheCity(n int, edges [][]int, distanceThreshold int) int {
    graph := make([][]Edge, n)
    for _, edge := range edges {
        graph[edge[0]] = append(graph[edge[0]], Edge{to: edge[1], weight: edge[2]})
        graph[edge[1]] = append(graph[edge[1]], Edge{to: edge[0], weight: edge[2]})
    }

    minNeighbors := n + 1
    cityWithMinNeighbors := n

    for i := 0; i < n; i++ {
        neighborsCount := dijkstra(i, graph, distanceThreshold)
        if neighborsCount < minNeighbors || (neighborsCount == minNeighbors && i < cityWithMinNeighbors) {
            minNeighbors = neighborsCount
            cityWithMinNeighbors = i
        }
    }

    return cityWithMinNeighbors
}

func dijkstra(start int, graph [][]Edge, distanceThreshold int) int {
    dist := make([]int, len(graph))
    for i := range dist {
        dist[i] = math.MaxInt32
    }
    dist[start] = 0

    pq := make([][2]int, 0)
    pq = append(pq, [2]int{0, start})

    for len(pq) > 0 {
        curr := pq[0]
        pq = pq[1:]

        currDist, currNode := curr[0], curr[1]

        if currDist > dist[currNode] {
            continue
        }

        for _, edge := range graph[currNode] {
            if dist[currNode]+edge.weight < dist[edge.to] {
                dist[edge.to] = dist[currNode] + edge.weight
                pq = append(pq, [2]int{dist[edge.to], edge.to})
            }
        }
    }

    count := 0
    for _, d := range dist {
        if d <= distanceThreshold {
            count++
        }
    }

    return count - 1 // Exclude the start city itself
}