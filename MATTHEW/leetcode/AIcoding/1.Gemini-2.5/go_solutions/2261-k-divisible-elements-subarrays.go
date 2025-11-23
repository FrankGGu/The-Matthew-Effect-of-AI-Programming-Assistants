package main

import (
	"strconv"
	"strings"
)

func countDistinct(nums []int, k int, p int) int {
	distinctSubarrays := make(map[string]struct{})
	n := len(nums)

	for i := 0; i < n; i++ {
		countDivisible := 0
		var sb strings.Builder

		for j := i; j < n; j++ {
			if nums[j]%p == 0 {
				countDivisible++
			}

			if countDivisible <= k {
				sb.WriteString(strconv.Itoa(nums[j]))
				sb.WriteString(",")
				distinctSubarrays[sb.String()] = struct{}{}
			} else {
				break
			}
		}
	}

	return len(distinctSubarrays)
}