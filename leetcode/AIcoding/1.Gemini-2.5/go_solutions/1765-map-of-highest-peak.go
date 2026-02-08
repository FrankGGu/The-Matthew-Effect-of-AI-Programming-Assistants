package main

type pair struct {
	r, c int
}

func highestPeak(isWater [][]int) [][]int {
	m := len(isWater)
	n := len(isWater[0])

	result := make([][]int, m)
	for i := range result {
		result[i] = make([]int, n)
	}

	q := []pair{}

	for i := 0; i < m; i++ {
		for j := 0; j < n; j++ {
			if isWater[i][j] == 1 {
				result[i][j] = 0
				q = append(q, pair{i, j})
			} else {
				result[i][j] = -1 // Mark as unvisited land
			}
		}
	}

	dirs := []pair{{0, 1}, {0, -1}, {1, 0}, {-1, 0}}

	head := 0
	for head < len(q) {
		curr := q[head]
		head++

		r, c := curr.r, curr.c
		height := result[r][c]

		for _, dir := range dirs {
			nr, nc := r+dir.r, c+dir.c

			if nr >= 0 && nr < m && nc >= 0 && nc < n && result[nr][nc] == -1 {
				result[nr][nc] = height + 1
				q = append(q, pair{nr, nc})
			}
		}
	}

	return result
}