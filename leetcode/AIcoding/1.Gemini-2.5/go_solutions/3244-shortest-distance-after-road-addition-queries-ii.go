package main

import (
	"bufio"
	"fmt"
	"math"
	"os"
	"strconv"
)

const INF int64 = math.MaxInt64 / 2 // Use a large enough value, but not MaxInt64 directly to avoid overflow when adding

func solve() {
	scanner := bufio.NewScanner(os.Stdin)
	scanner.Split(bufio.ScanWords)

	readInt := func() int {
		scanner.Scan()
		n, _ := strconv.Atoi(scanner.Text())
		return n
	}
	readInt64 := func() int64 {
		scanner.Scan()
		n, _ := strconv.ParseInt(scanner.Text(), 10, 64)
		return n
	}

	n := readInt()
	m := readInt()

	dist := make([][]int64, n)
	for i := 0; i < n; i++ {
		dist[i] = make([]int64, n)
		for j := 0; j < n; j++ {
			if i == j {
				dist[i][j] = 0
			} else {
				dist[i][j] = INF
			}
		}
	}

	for k := 0; k < m; k++ {
		u, v, w := readInt()-1, readInt()-1, readInt64()
		dist[u][v] = min(dist[u][v], w)
		dist[v][u] = min(dist[v][u], w)
	}

	// Floyd-Warshall initial APSP calculation
	for k := 0; k < n; k++ {
		for i := 0; i < n; i++ {
			for j := 0; j < n; j++ {
				if dist[i][k] != INF && dist[k][j] != INF {
					dist[i][j] = min(dist[i][j], dist[i][k]+dist[k][j])
				}
			}
		}
	}

	q := readInt()
	results := make([]int64, q)

	for queryIdx := 0; queryIdx < q; queryIdx++ {
		u, v, w := readInt()-1, readInt()-1, readInt64()

		// Update the direct edge (u,v) and (v,u) with the new weight
		dist[u][v] = min(dist[u][v], w)
		dist[v][u] = min(dist[v][u], w)

		// Update all-pairs shortest paths using the new edge (u,v) or (v,u)
		// Any path i -> j can potentially be improved by going through u-v or v-u
		// i -> ... -> u -> v -> ... -> j
		// i -> ... -> v -> u -> ... -> j
		for i := 0; i < n; i++ {
			for j := 0; j < n; j++ {
				// Path through u-v
				if dist[i][u] != INF && dist[u][v] != INF && dist[v][j] != INF {
					dist[i][j] = min(dist[i][j], dist[i][u]+dist[u][v]+dist[v][j])
				}
				// Path through v-u
				if dist[i][v] != INF && dist[v][u] != INF && dist[u][j] != INF {
					dist[i][j] = min(dist[i][j], dist[i][v]+dist[v][u]+dist[u][j])
				}
			}
		}

		// Recalculate the sum of all shortest distances (for i < j)
		currentSum := int64(0)
		for i := 0; i < n; i++ {
			for j := i + 1; j < n; j++ {
				currentSum += dist[i][j]
			}
		}
		results[queryIdx] = currentSum
	}

	writer := bufio.NewWriter(os.Stdout)
	defer writer.Flush()
	for _, res := range results {
		fmt.Fprintln(writer, res)
	}
}

func min(a, b int64) int64 {
	if a < b {
		return a
	}
	return b
}

func main() {
	solve()
}