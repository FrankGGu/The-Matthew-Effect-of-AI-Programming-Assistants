package main

import (
	"fmt"
	"sort"
)

func countArrangement(N int) int {
	count := 0
	visited := make([]bool, N+1)
	var backtrack func(pos int)
	backtrack = func(pos int) {
		if pos > N {
			count++
			return
		}
		for i := 1; i <= N; i++ {
			if !visited[i] && (i%pos == 0 || pos%i == 0) {
				visited[i] = true
				backtrack(pos + 1)
				visited[i] = false
			}
		}
	}
	backtrack(1)
	return count
}

func main() {
	fmt.Println(countArrangement(2)) // Example usage
}