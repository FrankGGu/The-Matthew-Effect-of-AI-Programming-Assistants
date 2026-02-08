func findMaxConsecutiveOnes(nums []int) int {
    maxCount, count := 0, 0
    for _, num := range nums {
        if num == 1 {
            count++
        } else {
            if count > maxCount {
                maxCount = count
            }
            count = 0
        }
    }
    if count > maxCount {
        maxCount = count
    }
    return maxCount
}