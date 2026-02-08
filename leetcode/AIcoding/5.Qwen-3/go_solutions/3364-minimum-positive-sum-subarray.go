package main

func minimumPositiveSumSubarray(nums []int) int {
    minSum := 1<<31 - 1
    currentSum := 0

    for _, num := range nums {
        currentSum += num
        if currentSum > 0 {
            if currentSum < minSum {
                minSum = currentSum
            }
        } else {
            currentSum = 0
        }
    }

    return minSum
}