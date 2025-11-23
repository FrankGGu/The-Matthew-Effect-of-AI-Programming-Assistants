package main

import (
	"fmt"
)

func findLexSmallestSequence(n int, k int) []int {
	result := make([]int, n)
	visited := make([]bool, n+1)
	var backtrack func(pos int)
	backtrack = func(pos int) {
		if pos == n {
			return
		}
		for i := 1; i <= n; i++ {
			if !visited[i] {
				result[pos] = i
				visited[i] = true
				backtrack(pos + 1)
				if pos == n-1 {
					return
				}
				visited[i] = false
			}
		}
	}
	backtrack(0)
	return result
}

func main() {
	n := 3
	k := 2
	res := findLexSmallestSequence(n, k)
	fmt.Println(res)
}