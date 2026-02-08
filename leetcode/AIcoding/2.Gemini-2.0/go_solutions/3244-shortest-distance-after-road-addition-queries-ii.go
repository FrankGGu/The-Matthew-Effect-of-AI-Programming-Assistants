func shortestDistance(n int, edges [][]int, queries [][]int) []int64 {
	dist := make([][]int64, n)
	for i := 0; i < n; i++ {
		dist[i] = make([]int64, n)
		for j := 0; j < n; j++ {
			if i == j {
				dist[i][j] = 0
			} else {
				dist[i][j] = int64(1e15)
			}
		}
	}

	for _, edge := range edges {
		u, v, w := edge[0], edge[1], edge[2]
		dist[u][v] = int64(w)
		dist[v][u] = int64(w)
	}

	for k := 0; k < n; k++ {
		for i := 0; i < n; i++ {
			for j := 0; j < n; j++ {
				dist[i][j] = min(dist[i][j], dist[i][k]+dist[k][j])
			}
		}
	}

	ans := make([]int64, len(queries))
	for i, query := range queries {
		u, v, w := query[0], query[1], query[2]

		tempDist := make([][]int64, n)
        for r := 0; r < n; r++ {
            tempDist[r] = make([]int64, n)
            for c := 0; c < n; c++ {
                tempDist[r][c] = dist[r][c]
            }
        }

		for r := 0; r < n; r++ {
            tempDist[r][u] = min(tempDist[r][u], tempDist[r][v] + int64(w))
            tempDist[r][v] = min(tempDist[r][v], tempDist[r][u] + int64(w))
        }

		for c := 0; c < n; c++ {
            tempDist[u][c] = min(tempDist[u][c], tempDist[v][c] + int64(w))
            tempDist[v][c] = min(tempDist[v][c], tempDist[u][c] + int64(w))
        }

		tempDist[u][v] = int64(w)
        tempDist[v][u] = int64(w)

		for k := 0; k < n; k++ {
            for i := 0; i < n; i++ {
                for j := 0; j < n; j++ {
                    tempDist[i][j] = min(tempDist[i][j], tempDist[i][k] + tempDist[k][j])
                }
            }
        }

		sum := int64(0)
		for r := 0; r < n; r++ {
            for c := r + 1; c < n; c++ {
                sum += tempDist[r][c]
            }
        }
		ans[i] = sum
	}

	return ans
}

func min(a, b int64) int64 {
	if a < b {
		return a
	}
	return b
}