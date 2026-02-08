package main

func max连续销售额(销售记录 []int) int {
    if len(销售记录) == 0 {
        return 0
    }

    maxSum := 销售记录[0]
    currentSum := 销售记录[0]

    for i := 1; i < len(销售记录); i++ {
        currentSum = max(销售记录[i], currentSum+销售记录[i])
        maxSum = max(maxSum, currentSum)
    }

    return maxSum
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}