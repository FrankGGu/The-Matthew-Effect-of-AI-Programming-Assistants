func kConcatenationMaxSum(arr []int, k int) int {
    mod := int(1e9 + 7)

    maxEndingHere := 0
    maxSoFar := 0
    totalSum := 0

    for _, num := range arr {
        totalSum += num
        maxEndingHere = max(maxEndingHere + num, num)
        maxSoFar = max(maxSoFar, maxEndingHere)
    }

    if k == 1 {
        return maxSoFar % mod
    }

    maxPrefixSum := 0
    currentPrefixSum := 0
    for _, num := range arr {
        currentPrefixSum += num
        maxPrefixSum = max(maxPrefixSum, currentPrefixSum)
    }

    maxSuffixSum := 0
    currentSuffixSum := 0
    for i := len(arr) - 1; i >= 0; i-- {
        currentSuffixSum += arr[i]
        maxSuffixSum = max(maxSuffixSum, currentSuffixSum)
    }

    if totalSum > 0 {
        return (max(maxSoFar, maxSuffixSum + maxPrefixSum + (k-2)*totalSum)) % mod
    }

    return max(maxSoFar, maxSuffixSum) % mod
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}