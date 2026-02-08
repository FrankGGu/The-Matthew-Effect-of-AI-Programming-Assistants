package main

func kSum(ints []int, k int) int {
    n := len(ints)
    sum := 0
    for i := 0; i < k; i++ {
        sum += ints[i]
    }
    maxSum := sum
    for i := k; i < n; i++ {
        sum += ints[i] - ints[i-k]
        if sum > maxSum {
            maxSum = sum
        }
    }
    return maxSum
}