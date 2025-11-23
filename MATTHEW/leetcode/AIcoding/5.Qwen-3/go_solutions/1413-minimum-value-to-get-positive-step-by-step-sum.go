package main

func minStartValue(nums []int) int {
    sum := 0
    minSum := 0
    for _, num := range nums {
        sum += num
        if sum < minSum {
            minSum = sum
        }
    }
    return 1 - minSum
}