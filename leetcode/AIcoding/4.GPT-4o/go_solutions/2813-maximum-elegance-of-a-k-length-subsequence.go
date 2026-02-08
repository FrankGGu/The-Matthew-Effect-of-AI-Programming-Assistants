package main

import (
	"fmt"
	"sort"
)

func maxElegance(nums []int, k int) int64 {
	sort.Slice(nums, func(i, j int) bool {
		return nums[i] > nums[j]
	})

	n := len(nums)
	uniqueCount := make(map[int]int)
	var currentElegance int64

	for i := 0; i < k; i++ {
		if uniqueCount[nums[i]] == 0 {
			currentElegance += int64(nums[i])
			uniqueCount[nums[i]]++
		}
	}

	maxElegance := currentElegance + int64(len(uniqueCount))

	for i := k; i < n; i++ {
		if uniqueCount[nums[i]] == 0 {
			if len(uniqueCount) < k {
				currentElegance += int64(nums[i])
				uniqueCount[nums[i]]++
			} else {
				minValue := -1
				for num := range uniqueCount {
					if minValue == -1 || minValue > num {
						minValue = num
					}
				}
				if minValue < nums[i] {
					currentElegance += int64(nums[i]) - int64(minValue)
					delete(uniqueCount, minValue)
					uniqueCount[nums[i]]++
				}
			}
		}
		maxElegance = max(maxElegance, currentElegance+int64(len(uniqueCount)))
	}

	return maxElegance
}

func max(a, b int64) int64 {
	if a > b {
		return a
	}
	return b
}

func main() {
	nums := []int{3, 6, 3, 3, 3}
	k := 3
	fmt.Println(maxElegance(nums, k))
}