package main

import (
	"math"
)

func minimumAverageDifference(nums []int) int {
	n := len(nums)

	var totalSum int64
	for _, num := range nums {
		totalSum += int64(num)
	}

	var minAvgDiff int64 = math.MaxInt64
	resultIndex := -1

	var leftSum int64
	for i := 0; i < n; i++ {
		leftSum += int64(nums[i])

		leftCount := i + 1
		rightCount := n - i - 1

		var leftAvg int64
		leftAvg = leftSum / int64(leftCount)

		var rightAvg int64
		if rightCount == 0 {
			rightAvg = 0
		} else {
			rightAvg = (totalSum - leftSum) / int64(rightCount)
		}

		currentAvgDiff := leftAvg - rightAvg
		if currentAvgDiff < 0 {
			currentAvgDiff = -currentAvgDiff
		}

		if currentAvgDiff < minAvgDiff {
			minAvgDiff = currentAvgDiff
			resultIndex = i
		}
	}

	return resultIndex
}