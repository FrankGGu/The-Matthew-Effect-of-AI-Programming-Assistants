func findMaxLength(nums []int) int {
    maxLen := 0
    count := 0
    countMap := make(map[int]int)
    countMap[0] = -1

    for i, num := range nums {
        if num == 0 {
            count--
        } else {
            count++
        }
        if prevIndex, exists := countMap[count]; exists {
            if i - prevIndex > maxLen {
                maxLen = i - prevIndex
            }
        } else {
            countMap[count] = i
        }
    }

    return maxLen
}