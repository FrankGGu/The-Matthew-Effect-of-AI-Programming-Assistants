package main

import (
	"fmt"
)

func canMakePaliQueries(s string, queries [][]int) []bool {
	count := make([][26]int, len(s)+1)
	for i, c := range s {
		count[i+1] = count[i]
		count[i+1][c-'a']++
	}

	res := make([]bool, len(queries))
	for i, query := range queries {
		l, r, k := query[0], query[1], query[2]
		oddCount := 0
		for j := 0; j < 26; j++ {
			if (count[r+1][j] - count[l][j])%2 != 0 {
				oddCount++
			}
		}
		res[i] = oddCount/2 <= k
	}
	return res
}

func main() {
	s := "abcda"
	queries := [][]int{{1, 3, 0}, {0, 4, 1}, {1, 4, 1}}
	fmt.Println(canMakePaliQueries(s, queries))
}