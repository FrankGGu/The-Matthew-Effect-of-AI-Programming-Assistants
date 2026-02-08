package main

import "math"

func maxSideLength(mat [][]int, threshold int) int {
	m := len(mat)
	n := len(mat[0])

	ps := make([][]int, m+1)
	for i := range ps {
		ps[i] = make([]int, n+1)
	}

	for i := 1; i <= m; i++ {
		for j := 1; j <= n; j++ {
			ps[i][j] = mat[i-1][j-1] + ps[i-1][j] + ps[i][j-1] - ps[i-1][j-1]
		}
	}

	check := func(k int) bool {
		if k == 0 {
			return true
		}
		for r := 0; r <= m-k; r++ {
			for c := 0; c <= n-k; c++ {
				currentSum := ps[r+k][c+k] - ps[r][c+k] - ps[r+k][c] + ps[r][c]
				if currentSum <= threshold {
					return true
				}
			}
		}
		return false
	}

	maxSide := 0
	low := 0
	high := int(math.Min(float64(m), float64(n)))

	for low <= high {
		mid := low + (high-low)/2
		if check(mid) {
			maxSide = mid
			low = mid + 1
		} else {
			high = mid - 1
		}
	}

	return maxSide
}