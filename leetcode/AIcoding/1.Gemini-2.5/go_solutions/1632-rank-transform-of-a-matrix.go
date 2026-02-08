package main

import (
	"sort"
)

type Cell struct {
	val int
	r   int
	c   int
}

type DSU struct {
	parent []int
}

func newDSU(n int) *DSU {
	parent := make([]int, n)
	for i := range parent {
		parent[i] = i
	}
	return &DSU{parent: parent}
}

func (d *DSU) find(i int) int {
	if d.parent[i] == i {
		return i
	}
	d.parent[i] = d.find(d.parent[i])
	return d.parent[i]
}

func (d *DSU) union(i, j int) {
	rootI := d.find(i)
	rootJ := d.find(j)
	if rootI != rootJ {
		d.parent[rootJ] = rootI
	}
}

func matrixRankTransform(matrix [][]int) [][]int {
	m := len(matrix)
	n := len(matrix[0])

	// Collect all cells with their values and coordinates.
	cells := make([]Cell, 0, m*n)
	for r := 0; r < m; r++ {
		for c := 0; c < n; c++ {
			cells = append(cells, Cell{matrix[r][c], r, c})
		}
	}

	// Sort cells primarily by their value in ascending order.
	sort.Slice(cells, func(i, j int) bool {
		return cells[i].val < cells[j].val
	})

	// Initialize the answer matrix.
	ans := make([][]int, m)
	for i := range ans {
		ans[i] = make([]int, n)
	}

	// rowMaxRank[r] stores the maximum rank assigned so far in row r.
	// colMaxRank[c] stores the maximum rank assigned so far in column c.
	rowMaxRank := make([]int, m)
	colMaxRank := make([]int, n)

	// Iterate through sorted cells, processing groups of cells with the same value.
	i := 0
	for i < len(cells) {
		j := i
		// Find the end of the current group (all cells with the same value).
		for j < len(cells) && cells[j].val == cells[i].val {
			j++
		}
		currentGroup := cells[i:j] // Slice containing cells of the current value.

		// Create a temporary DSU for elements within this group.
		// DSU elements are indices into currentGroup.
		dsu := newDSU(len(currentGroup))

		// Maps to connect cells in the same row/column within this group.
		// rowMap[r] stores the index in currentGroup of the first cell encountered in row r.
		// colMap[c] stores the index in currentGroup of the first cell encountered in column c.
		rowMap := make(map[int]int)
		colMap := make(map[int]int)

		// Perform unions based on shared rows/columns within the current group.
		for k, cell := range currentGroup {
			if prevIdx, found := rowMap[cell.r]; found {
				dsu.union(k, prevIdx)
			}
			if prevIdx, found := colMap[cell.c]; found {
				dsu.union(k, prevIdx)
			}
			rowMap[cell.r] = k
			colMap[cell.c] = k
		}

		// Calculate the maximum previous rank for each connected component.
		// rootToMaxPrevRank[root] stores the maximum of (rowMaxRank[r], colMaxRank[c])
		// for all cells (r, c) belonging to the component represented by 'root'.
		rootToMaxPrevRank := make(map[int]int)
		for k, cell := range currentGroup {
			root := dsu.find(k)
			currentPrevRank := rowMaxRank[cell.r]
			if colMaxRank[cell.c] > currentPrevRank {
				currentPrevRank = colMaxRank[cell.c]
			}

			if val, ok := rootToMaxPrevRank[root]; !ok || currentPrevRank > val {
				rootToMaxPrevRank[root] = currentPrevRank
			}
		}

		// Assign final ranks to cells in the current group.
		// All cells in a connected component get the same rank.
		for k, cell := range currentGroup {
			root := dsu.find(k)
			finalRank := rootToMaxPrevRank[root] + 1
			ans[cell.r][cell.c] = finalRank
		}

		// Update rowMaxRank and colMaxRank for all affected rows/columns.
		// This must be done AFTER all ranks for the current value group are determined
		// to ensure consistent previous ranks for cells within the same group.
		for _, cell := range currentGroup {
			finalRank := ans[cell.r][cell.c]
			if finalRank > rowMaxRank[cell.r] {
				rowMaxRank[cell.r] = finalRank
			}
			if finalRank > colMaxRank[cell.c] {
				colMaxRank[cell.c] = finalRank
			}
		}

		i = j // Move to the next group of distinct values.
	}

	return ans
}