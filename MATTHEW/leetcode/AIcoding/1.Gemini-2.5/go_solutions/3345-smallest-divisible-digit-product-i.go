package main

import (
	"strconv"
)

func smallestDivisibleDigitProductI(n int) string {
	if n == 1 {
		return "1"
	}

	type State struct {
		remX    int // current_number % n
		remProd int // product_of_non_zero_digits % n
	}

	type QueueItem struct {
		remX      int
		remProd   int
		parentIdx int // index in the queue for the parent item
		digit     int // the digit added to reach this state
	}

	q := []QueueItem{}
	visited := make(map[State]bool)

	// Initialize queue with single-digit numbers (1-9)
	for d := 1; d <= 9; d++ {
		remX := d % n
		remProd := d % n

		if remX == 0 && remProd == 0 {
			return strconv.Itoa(d)
		}

		currState := State{remX, remProd}
		if !visited[currState] {
			visited[currState] = true
			q = append(q, QueueItem{remX, remProd, -1, d})
		}
	}

	head := 0
	for head < len(q) {
		curr := q[head]
		head++

		for d := 0; d <= 9; d++ {
			nextRemX := (curr.remX*10 + d) % n

			nextRemProd := curr.remProd
			if d == 0 {
				// If a '0' digit is added, the product of digits becomes 0.
				// For n > 0, 0 is divisible by n (0 % n == 0).
				nextRemProd = 0
			} else {
				nextRemProd = (curr.remProd * d) % n
			}

			if nextRemX == 0 && nextRemProd == 0 {
				// Found the smallest number. Reconstruct the path.
				path := []int{d}
				idx := head - 1 // Index of curr in q
				for idx != -1 {
					path = append(path, q[idx].digit)
					idx = q[idx].parentIdx
				}

				// Build the string in correct order (digits were appended in reverse)
				res := make([]byte, 0, len(path))
				for i := len(path) - 1; i >= 0; i-- {
					res = append(res, byte('0'+path[i]))
				}
				return string(res)
			}

			nextState := State{nextRemX, nextRemProd}
			if !visited[nextState] {
				visited[nextState] = true
				q = append(q, QueueItem{nextRemX, nextRemProd, head - 1, d})
			}
		}
	}

	return "" // Should not be reached if a solution always exists
}