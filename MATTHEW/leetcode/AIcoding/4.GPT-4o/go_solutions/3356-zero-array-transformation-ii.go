func canTransform(nums []int) bool {
    n := len(nums)
    sum := 0
    for _, num := range nums {
        sum += num
    }
    if sum%3 != 0 {
        return false
    }
    target := sum / 3
    currentSum := 0
    count := 0
    for _, num := range nums {
        currentSum += num
        if currentSum == target {
            currentSum = 0
            count++
        }
    }
    return count >= 3
}