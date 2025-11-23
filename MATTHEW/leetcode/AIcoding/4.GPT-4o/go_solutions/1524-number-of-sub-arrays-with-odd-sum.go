func numOfSubarrays(arr []int) int {
    oddCount, evenCount, oddSumCount := 0, 1, 0
    currentSum := 0
    mod := 1000000007

    for _, num := range arr {
        currentSum += num
        if currentSum % 2 == 0 {
            oddCount += oddSumCount
            evenCount++
        } else {
            oddCount += evenCount
            oddSumCount++
        }
    }

    return oddCount % mod
}