import "math"

func minTrioDegree(n int, edges [][]int) int {
	adj := make([][]bool, n+1)
	for i := range adj {
		adj[i] = make([]bool, n+1)
	}

	degrees := make([]int, n+1)

	for _, edge := range edges {
		u, v := edge[0], edge[1]
		adj[u][v] = true
		adj[v][u] = true
		degrees[u]++
		degrees[v]++
	}

	minDegree := math.MaxInt32

	for i := 1; i <= n; i++ {
		for j := i + 1; j <= n; j++ {
			if adj[i][j] { // If i and j are connected
				for k := j + 1; k <= n; k++ {
					if adj[j][k] && adj[k][i] { // If j and k are connected, and k and i are connected
						// Found a connected trio (i, j, k)
						currentTrioDegree := degrees[i] + degrees[j] + degrees[k] - 6
						if currentTrioDegree < minDegree {
							minDegree = currentTrioDegree
						}
					}
				}
			}
		}
	}

	if minDegree == math.MaxInt32 {
		return -1
	}
	return minDegree
}