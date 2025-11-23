package main

import (
	"sort"
)

func diagonalSort(mat [][]int) [][]int {
	m := len(mat)
	n := len(mat[0])

	for j := 0; j < n; j++ {
		temp := []int{}
		r, c := 0, j
		for r < m && c < n {
			temp = append(temp, mat[r][c])
			r++
			c++
		}
		sort.Ints(temp)

		r, c = 0, j
		k := 0
		for r < m && c < n {
			mat[r][c] = temp[k]
			r++
			c++
			k++
		}
	}

	for i := 1; i < m; i++ {
		temp := []int{}
		r, c := i, 0
		for r < m && c < n {
			temp = append(temp, mat[r][c])
			r++
			c++
		}
		sort.Ints(temp)

		r, c = i, 0
		k := 0
		for r < m && c < n {
			mat[r][c] = temp[k]
			r++
			c++
			k++
		}
	}

	return mat
}