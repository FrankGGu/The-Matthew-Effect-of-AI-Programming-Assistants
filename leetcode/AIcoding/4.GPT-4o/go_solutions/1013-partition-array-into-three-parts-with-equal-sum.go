func canThreePartsEqualSum(A []int) bool {
    totalSum := 0
    for _, num := range A {
        totalSum += num
    }
    if totalSum%3 != 0 {
        return false
    }
    target := totalSum / 3
    currentSum, count := 0, 0
    for _, num := range A {
        currentSum += num
        if currentSum == target {
            count++
            currentSum = 0
        }
    }
    return count >= 3
}