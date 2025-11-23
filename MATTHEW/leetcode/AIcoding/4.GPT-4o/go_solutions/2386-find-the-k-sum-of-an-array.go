package main

import (
	"sort"
)

func kSum(A []int, K int, target int) [][]int {
	sort.Ints(A)
	return kSumHelper(A, K, target, 0)
}

func kSumHelper(A []int, K int, target int, start int) [][]int {
	if K == 2 {
		return twoSum(A, target, start)
	}
	res := [][]int{}
	for i := start; i < len(A)-K+1; i++ {
		if i > start && A[i] == A[i-1] {
			continue
		}
		for _, subset := range kSumHelper(A, K-1, target-A[i], i+1) {
			res = append(res, append([]int{A[i]}, subset...))
		}
	}
	return res
}

func twoSum(A []int, target int, start int) [][]int {
	res := [][]int{}
	lo, hi := start, len(A)-1
	for lo < hi {
		sum := A[lo] + A[hi]
		if sum < target {
			lo++
		} else if sum > target {
			hi--
		} else {
			res = append(res, []int{A[lo], A[hi]})
			lo++
			hi--
			for lo < hi && A[lo] == A[lo-1] {
				lo++
			}
			for lo < hi && A[hi] == A[hi+1] {
				hi--
			}
		}
	}
	return res
}