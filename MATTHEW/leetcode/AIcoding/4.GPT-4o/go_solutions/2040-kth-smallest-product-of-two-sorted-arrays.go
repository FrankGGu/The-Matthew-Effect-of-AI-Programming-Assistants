package main

import (
	"sort"
)

func kthSmallestProduct(A []int, B []int, k int) int {
	low, high := 0, A[len(A)-1]*B[len(B)-1]
	for low < high {
		mid := low + (high-low)/2
		if countLessEqual(A, B, mid) < k {
			low = mid + 1
		} else {
			high = mid
		}
	}
	return low
}

func countLessEqual(A, B []int, x int) int {
	count := 0
	for _, a := range A {
		if a > x {
			break
		}
		count += sort.Search(len(B), func(j int) bool {
			return a*B[j] > x
		})
	}
	return count
}