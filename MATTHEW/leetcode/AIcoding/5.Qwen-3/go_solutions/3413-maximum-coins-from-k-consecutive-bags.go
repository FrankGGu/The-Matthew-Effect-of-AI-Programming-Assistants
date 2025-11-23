package main

func maxCoins(bags []int, k int) int {
    n := len(bags)
    if k == 0 || n == 0 {
        return 0
    }
    if k >= n {
        sum := 0
        for _, v := range bags {
            sum += v
        }
        return sum
    }
    maxSum := 0
    currentSum := 0
    for i := 0; i < k; i++ {
        currentSum += bags[i]
    }
    maxSum = currentSum
    for i := k; i < n; i++ {
        currentSum += bags[i] - bags[i-k]
        if currentSum > maxSum {
            maxSum = currentSum
        }
    }
    return maxSum
}