package main

func equalSumGridPartitionII(grid [][]int) bool {
	m := len(grid)
	n := len(grid[0])

	if m < 4 || n < 4 {
		return false
	}

	ps := make([][]int, m+1)
	for i := range ps {
		ps[i] = make([]int, n+1)
	}

	for i := 0; i < m; i++ {
		for j := 0; j < n; j++ {
			ps[i+1][j+1] = grid[i][j] + ps[i][j+1] + ps[i+1][j] - ps[i][j]
		}
	}

	getSum := func(r1, c1, r2, c2 int) int {
		if r1 > r2 || c1 > c2 {
			return 0
		}
		return ps[r2+1][c2+1] - ps[r1][c2+1] - ps[r2+1][c1] + ps[r1][c1]
	}

	for r1 := 1; r1 <= m-3; r1++ {
		for r2 := r1 + 2; r2 <= m-1; r2++ {
			for c1 := 1; c1 <= n-3; c1++ {
				for c2 := c1 + 2; c2 <= n-1; c2++ {
					s1 := getSum(0, 0, r1-1, c1-1)
					s2 := getSum(0, c2, r1-1, n-1)
					s3 := getSum(r2, 0, m-1, c1-1)
					s4 := getSum(r2, c2, m-1, n-1)

					if s1 == s2 && s2 == s3 && s3 == s4 {
						return true
					}
				}
			}
		}
	}

	return false
}