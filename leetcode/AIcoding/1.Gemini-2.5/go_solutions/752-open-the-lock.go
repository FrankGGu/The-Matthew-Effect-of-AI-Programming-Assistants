package main

import (
	"strconv"
)

func openLock(deadends []string, target string) int {
	deadSet := make(map[string]bool)
	for _, d := range deadends {
		deadSet[d] = true
	}

	if deadSet["0000"] {
		return -1
	}

	if target == "0000" {
		return 0
	}

	queue := []string{"0000"}
	visited := make(map[string]bool)
	visited["0000"] = true
	steps := 0

	for len(queue) > 0 {
		levelSize := len(queue)
		for i := 0; i < levelSize; i++ {
			current := queue[0]
			queue = queue[1:]

			for j := 0; j < 4; j++ {
				charDigit := current[j] - '0'

				// Increment
				nextDigitUp := (charDigit + 1) % 10
				nextUp := []byte(current)
				nextUp[j] = nextDigitUp + '0'
				nextUpStr := string(nextUp)

				if nextUpStr == target {
					return steps + 1
				}
				if !deadSet[nextUpStr] && !visited[nextUpStr] {
					visited[nextUpStr] = true
					queue = append(queue, nextUpStr)
				}

				// Decrement
				nextDigitDown := (charDigit - 1 + 10) % 10
				nextDown := []byte(current)
				nextDown[j] = nextDigitDown + '0'
				nextDownStr := string(nextDown)

				if nextDownStr == target {
					return steps + 1
				}
				if !deadSet[nextDownStr] && !visited[nextDownStr] {
					visited[nextDownStr] = true
					queue = append(queue, nextDownStr)
				}
			}
		}
		steps++
	}

	return -1
}