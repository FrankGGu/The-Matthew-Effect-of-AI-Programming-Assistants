import (
	"math"
)

func findTheCity(n int, edges [][]int, distanceThreshold int) int {
	dist := make([][]int, n)
	for i := range dist {
		dist[i] = make([]int, n)
		for j := range dist[i] {
			if i == j {
				dist[i][j] = 0
			} else {
				dist[i][j] = math.MaxInt32
			}
		}
	}

	for _, edge := range edges {
		u, v, w := edge[0], edge[1], edge[2]
		dist[u][v] = w
		dist[v][u] = w
	}

	for k := 0; k < n; k++ {
		for i := 0; i < n; i++ {
			for j := 0; j < n; j++ {
				if dist[i][k] != math.MaxInt32 && dist[k][j] != math.MaxInt32 && dist[i][k]+dist[k][j] < dist[i][j] {
					dist[i][j] = dist[i][k] + dist[k][j]
				}
			}
		}
	}

	minCities := n + 1
	cityIndex := -1

	for i := 0; i < n; i++ {
		reachableCities := 0
		for j := 0; j < n; j++ {
			if i != j && dist[i][j] <= distanceThreshold {
				reachableCities++
			}
		}

		if reachableCities <= minCities {
			minCities = reachableCities
			cityIndex = i
		}
	}

	return cityIndex
}