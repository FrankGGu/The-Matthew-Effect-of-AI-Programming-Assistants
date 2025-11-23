package main

func maxEvenOdd(nums []int) int {
    maxDiff := -1
    for i := 0; i < len(nums); i++ {
        if nums[i]%2 == 0 {
            for j := i + 1; j < len(nums); j++ {
                if nums[j]%2 == 1 {
                    diff := nums[i] - nums[j]
                    if diff > maxDiff {
                        maxDiff = diff
                    }
                }
            }
        } else {
            for j := i + 1; j < len(nums); j++ {
                if nums[j]%2 == 0 {
                    diff := nums[i] - nums[j]
                    if diff > maxDiff {
                        maxDiff = diff
                    }
                }
            }
        }
    }
    return maxDiff
}