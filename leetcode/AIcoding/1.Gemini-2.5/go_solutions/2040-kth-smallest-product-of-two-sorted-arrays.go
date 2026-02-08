package main

import (
	"math"
	"sort"
)

func countLE(val int64, nums1, nums2 []int) int {
	count := 0
	for _, x := range nums1 {
		if x == 0 {
			if val >= 0 {
				count += len(nums2)
			}
		} else if x > 0 {
			target := val / int64(x)
			count += sort.SearchInts(nums2, int(target)+1)
		} else { // x < 0
			floatTarget := float64(val) / float64(x)
			searchVal := int(math.Ceil(floatTarget))
			count += len(nums2) - sort.SearchInts(nums2, searchVal)
		}
	}
	return count
}

func kthSmallestProduct(nums1 []int, nums2 []int, k int64) int64 {
	low := int64(-1e10)
	high := int64(1e10)
	ans := high

	for low <= high {
		mid := low + (high-low)/2
		if countLE(mid, nums1, nums2) >= int(k) {
			ans = mid
			high = mid - 1
		} else {
			low = mid + 1
		}
	}
	return ans
}