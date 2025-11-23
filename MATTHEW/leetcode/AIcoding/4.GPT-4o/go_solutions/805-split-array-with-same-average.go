package main

import "sort"

func splitArraySameAverage(A []int) bool {
	n := len(A)
	sum := 0
	for _, v := range A {
		sum += v
	}
	sort.Ints(A)
	for k := 1; k <= n/2; k++ {
		if sum*k%n == 0 {
			if canPartition(A, sum*k/n, k) {
				return true
			}
		}
	}
	return false
}

func canPartition(A []int, target int, k int) bool {
	n := len(A)
	dp := make([]bool, target+1)
	dp[0] = true
	for i := 0; i < n; i++ {
		for j := target; j >= A[i]; j-- {
			dp[j] = dp[j] || dp[j-A[i]]
		}
	}
	return dp[target]
}