package main

import (
	"container/list"
)

type State struct {
	gridInt int // Integer representation of the grid
	flips   int // Number of flips made
}

var R_global, C_global int

func gridToInt(grid [][]int) int {
	val := 0
	idx := 0
	for r := 0; r < R_global; r++ {
		for c := 0; c < C_global; c++ {
			if grid[r][c] == 1 {
				val |= (1 << idx)
			}
			idx++
		}
	}
	return val
}

func intToGrid(val int) [][]int {
	grid := make([][]int, R_global)
	for r := 0; r < R_global; r++ {
		grid[r] = make([]int, C_global)
		for c := 0; c < C_global; c++ {
			idx := r*C_global + c
			if (val>>idx)&1 == 1 {
				grid[r][c] = 1
			} else {
				grid[r][c] = 0
			}
		}
	}
	return grid
}

func applyFlip(grid [][]int, r, c int) {
	// Define relative coordinates for the cell itself and its 4 neighbors
	dr := []int{-1, 1, 0, 0, 0}
	dc := []int{0, 0, -1, 1, 0}

	for i := 0; i < 5; i++ {
		nr, nc := r+dr[i], c+dc[i]
		// Check boundaries
		if nr >= 0 && nr < R_global && nc >= 0 && nc < C_global {
			grid[nr][nc] = 1 - grid[nr][nc] // Toggle 0 to 1, 1 to 0
		}
	}
}

func isPalindromic(grid [][]int) bool {
	for r := 0; r < R_global; r++ {
		for c := 0; c < C_global; c++ {
			if grid[r][c] != grid[R_global-1-r][C_global-1-c] {
				return false
			}
		}
	}
	return true
}

func minFlips(grid [][]int) int {
	R_global = len(grid)
	C_global = len(grid[0])

	// Convert the initial grid to its integer representation
	initialGridInt := gridToInt(grid)

	// Initialize BFS queue
	q := list.New()
	q.PushBack(State{gridInt: initialGridInt, flips: 0})

	// Keep track of visited grid states to avoid redundant computations and cycles
	visited := make(map[int]bool)
	visited[initialGridInt] = true

	// BFS loop
	for q.Len() > 0 {
		e := q.Front()
		q.Remove(e)
		currState := e.Value.(State)

		// Convert the current integer state back to a 2D grid for checking and applying flips
		currGrid := intToGrid(currState.gridInt)

		// If the current grid is palindromic, we found the minimum number of flips
		// because BFS explores states layer by layer (shortest path first).
		if isPalindromic(currGrid) {
			return currState.flips
		}

		// Explore all possible next states by flipping each cell
		for r := 0; r < R_global; r++ {
			for c := 0; c < C_global; c++ {
				// Create a new grid from the current integer state to apply the flip
				nextGrid := intToGrid(currState.gridInt)
				applyFlip(nextGrid, r, c)
				nextGridInt := gridToInt(nextGrid)

				// If this new state has not been visited, add it to the queue
				if !visited[nextGridInt] {
					visited[nextGridInt] = true
					q.PushBack(State{gridInt: nextGridInt, flips: currState.flips + 1})
				}
			}
		}
	}

	// If the queue becomes empty and no palindromic grid was found, it's unreachable
	return -1
}