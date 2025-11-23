package main

import "math"

func findIndices(nums []int, indexDifference int, valueDifference int) []int {
    n := len(nums)

    minVal := nums[0]
    minIdx := 0
    maxVal := nums[0]
    maxIdx := 0

    for j := indexDifference; j < n; j++ {
        currentLeftIdx := j - indexDifference
        if nums[currentLeftIdx] < minVal {
            minVal = nums[currentLeftIdx]
            minIdx = currentLeftIdx
        }
        if nums[currentLeftIdx] > maxVal {
            maxVal = nums[currentLeftIdx]
            maxIdx = currentLeftIdx
        }

        if int(math.Abs(float64(nums[j] - minVal))) >= valueDifference {
            return []int{minIdx, j}
        }
        if int(math.Abs(float64(nums[j] - maxVal))) >= valueDifference {
            return []int{maxIdx, j}
        }
    }

    return []int{-1, -1}
}