package main

import (
	"fmt"
	"math"
	"sort"
)

func gcd(a, b int) int {
	for b != 0 {
		a, b = b, a%b
	}
	return a
}

func sortedGCDPairQueries(nums []int, queries [][]int) []int {
	n := len(nums)
	sort.Ints(nums)
	results := make([]int, len(queries))

	for i, query := range queries {
		l, r := query[0], query[1]
		maxGCD := 0

		for j := l; j <= r; j++ {
			for k := j + 1; k <= r; k++ {
				maxGCD = int(math.Max(float64(maxGCD), float64(gcd(nums[j], nums[k]))))
			}
		}
		results[i] = maxGCD
	}
	return results
}

func main() {
	nums := []int{2, 4, 6, 8}
	queries := [][]int{{0, 2}, {1, 3}}
	result := sortedGCDPairQueries(nums, queries)
	fmt.Println(result)
}