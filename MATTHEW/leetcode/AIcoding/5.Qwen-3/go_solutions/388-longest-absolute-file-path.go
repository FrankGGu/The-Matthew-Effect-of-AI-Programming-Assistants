package main

import (
	"strings"
)

func lengthLongestPath(input string) int {
	maxLength := 0
	pathLength := make(map[int]int)

	for _, line := range strings.Split(input, "\n") {
		name := line
		depth := 0
		for strings.HasPrefix(name, "\t") {
			depth++
			name = name[1:]
		}

		if strings.Contains(name, ".") {
			currentLength := pathLength[depth-1] + len(name)
			if currentLength > maxLength {
				maxLength = currentLength
			}
		} else {
			pathLength[depth] = pathLength[depth-1] + len(name)
		}
	}

	return maxLength
}