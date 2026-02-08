package main

import (
	"fmt"
	"math/bits"
)

func countNicePairs(nums []int) int {
	const mod = 1_000_000_007
	count := make(map[int]int)
	result := 0

	for _, num := range nums {
		reverse := 0
		n := num

		for n > 0 {
			reverse = reverse*10 + n%10
			n /= 10
		}

		diff := num - reverse
		result = (result + count[diff]) % mod
		count[diff]++
	}

	return result
}

func main() {
	nums := []int{42, 11, 1, 97}
	fmt.Println(countNicePairs(nums))
}