package main

import "sort"

func countRangeSum(nums []int, lower int, upper int) int {
	n := len(nums)
	preSum := make([]int, n+1)
	for i := 0; i < n; i++ {
		preSum[i+1] = preSum[i] + nums[i]
	}
	return mergeSort(preSum, 0, n, lower, upper)
}

func mergeSort(preSum []int, start, end, lower, upper int) int {
	if start >= end {
		return 0
	}
	mid := (start + end) / 2
	count := mergeSort(preSum, start, mid, lower, upper) + mergeSort(preSum, mid+1, end, lower, upper)
	j, k := mid+1, mid+1
	for i := start; i <= mid; i++ {
		for j <= end && preSum[j]-preSum[i] < lower {
			j++
		}
		for k <= end && preSum[k]-preSum[i] <= upper {
			k++
		}
		count += k - j
	}
	merge(preSum, start, mid, end)
	return count
}

func merge(preSum []int, start, mid, end int) {
	temp := make([]int, end-start+1)
	i, j, idx := start, mid+1, 0
	for i <= mid && j <= end {
		if preSum[i] <= preSum[j] {
			temp[idx] = preSum[i]
			i++
		} else {
			temp[idx] = preSum[j]
			j++
		}
		idx++
	}
	for i <= mid {
		temp[idx] = preSum[i]
		i++
		idx++
	}
	for j <= end {
		temp[idx] = preSum[j]
		j++
		idx++
	}
	for i := 0; i < len(temp); i++ {
		preSum[start+i] = temp[i]
	}
}