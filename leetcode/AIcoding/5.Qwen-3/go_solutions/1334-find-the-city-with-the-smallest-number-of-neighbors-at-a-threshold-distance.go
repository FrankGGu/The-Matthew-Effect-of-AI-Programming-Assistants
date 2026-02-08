package main

func findTheCity(n int, edges [][]int, distanceThreshold int) int {
    // Initialize adjacency matrix with infinity
    INF := 1000000
    dist := make([][]int, n)
    for i := range dist {
        dist[i] = make([]int, n)
        for j := range dist[i] {
            dist[i][j] = INF
        }
    }

    // Set direct edges
    for _, edge := range edges {
        u, v, w := edge[0], edge[1], edge[2]
        dist[u][v] = w
        dist[v][u] = w
    }

    // Floyd-Warshall algorithm
    for k := 0; k < n; k++ {
        for i := 0; i < n; i++ {
            for j := 0; j < n; j++ {
                if dist[i][k]+dist[k][j] < dist[i][j] {
                    dist[i][j] = dist[i][k] + dist[k][j]
                }
            }
        }
    }

    minCities := n
    resultCity := -1

    for i := 0; i < n; i++ {
        count := 0
        for j := 0; j < n; j++ {
            if i != j && dist[i][j] <= distanceThreshold {
                count++
            }
        }
        if count < minCities {
            minCities = count
            resultCity = i
        } else if count == minCities && i < resultCity {
            resultCity = i
        }
    }

    return resultCity
}