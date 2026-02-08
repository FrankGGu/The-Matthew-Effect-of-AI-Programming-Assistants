package main

import "fmt"

func substringXorQueries(s string, queries [][]int) [][]int {
	n := len(s)
	results := make([][]int, len(queries))
	for i, query := range queries {
		x := query[0]
		y := query[1]
		xor := x ^ y
		start := -1
		for j := 0; j < n; j++ {
			if s[j] == '0' && xor == 0 {
				start = j
				break
			}
			if s[j] == '1' {
				sub := 0
				for k := j; k < n; k++ {
					sub = (sub << 1) | int(s[k]-'0')
					if sub == xor {
						start = j
						break
					}
					if sub > xor {
						break
					}
				}
				if start != -1 {
					break
				}
			}
		}
		if start != -1 {
			results[i] = []int{start, start + 1}
		} else {
			results[i] = []int{-1, -1}
		}
	}
	return results
}

func main() {
	s := "101101"
	queries := [][]int{{0, 1}, {1, 2}, {2, 3}}
	result := substringXorQueries(s, queries)
	fmt.Println(result)
}