package main

import (
	"sort"
)

func sortByBits(arr []int) []int {
	sort.Slice(arr, func(i, j int) bool {
		a, b := arr[i], arr[j]
		bitCountA := countSetBits(a)
		bitCountB := countSetBits(b)

		if bitCountA != bitCountB {
			return bitCountA < bitCountB
		}
		return a < b
	})
	return arr
}

func countSetBits(n int) int {
	count := 0
	for n > 0 {
		n &= (n - 1)
		count++
	}
	return count
}