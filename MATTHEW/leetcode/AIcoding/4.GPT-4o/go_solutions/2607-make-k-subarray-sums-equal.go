func makeKSubarraySumsEqual(arr []int, n int, k int) bool {
    totalSum := 0
    for _, num := range arr {
        totalSum += num
    }

    if totalSum % k != 0 {
        return false
    }

    target := totalSum / k
    currentSum := 0
    count := 0

    for _, num := range arr {
        currentSum += num
        if currentSum == target {
            count++
            currentSum = 0
        } else if currentSum > target {
            return false
        }
    }

    return count >= k
}