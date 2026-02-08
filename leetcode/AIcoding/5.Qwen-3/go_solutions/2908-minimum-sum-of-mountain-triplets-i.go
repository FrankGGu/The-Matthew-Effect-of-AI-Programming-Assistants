package main

func minSumOfMountainTriplet(nums []int) int {
    n := len(nums)
    minSum := 1<<31 - 1

    for i := 1; i < n-1; i++ {
        for j := 0; j < i; j++ {
            if nums[j] < nums[i] {
                for k := i + 1; k < n; k++ {
                    if nums[k] < nums[i] {
                        sum := nums[j] + nums[i] + nums[k]
                        if sum < minSum {
                            minSum = sum
                        }
                    }
                }
            }
        }
    }

    if minSum == 1<<31 - 1 {
        return -1
    }

    return minSum
}