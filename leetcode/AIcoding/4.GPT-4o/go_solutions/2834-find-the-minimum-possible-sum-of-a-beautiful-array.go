package main

import "fmt"

func minBeautifulArray(n int) []int {
	result := make([]int, 0)
	used := make(map[int]bool)

	var backtrack func(int)
	backtrack = func(start int) {
		if start > n {
			return
		}
		if !used[start] {
			result = append(result, start)
			used[start] = true
			backtrack(start * 2)
			backtrack(start*2 + 1)
		}
	}

	backtrack(1)
	return result
}

func main() {
	n := 5 // Example input
	fmt.Println(minBeautifulArray(n))
}