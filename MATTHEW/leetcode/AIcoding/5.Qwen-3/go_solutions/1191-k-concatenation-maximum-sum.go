package main

func maxSubarraySum(arr []int) int {
    maxEndingHere := arr[0]
    maxSoFar := arr[0]
    for i := 1; i < len(arr); i++ {
        maxEndingHere = max(maxEndingHere+arr[i], arr[i])
        maxSoFar = max(maxSoFar, maxEndingHere)
    }
    return maxSoFar
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func kConcatenationMaxSum(arr []int, k int) int {
    if k == 1 {
        return maxSubarraySum(arr)
    }
    totalSum := 0
    for _, num := range arr {
        totalSum += num
    }
    maxSingle := maxSubarraySum(arr)
    maxPrefix := arr[0]
    current := arr[0]
    for i := 1; i < len(arr); i++ {
        current += arr[i]
        maxPrefix = max(maxPrefix, current)
    }
    maxSuffix := arr[len(arr)-1]
    current = arr[len(arr)-1]
    for i := len(arr) - 2; i >= 0; i-- {
        current += arr[i]
        maxSuffix = max(maxSuffix, current)
    }
    maxDouble := maxPrefix + maxSuffix
    if totalSum > 0 {
        return max(maxSingle, maxDouble + (k-2)*totalSum)
    }
    return max(maxSingle, maxDouble)
}