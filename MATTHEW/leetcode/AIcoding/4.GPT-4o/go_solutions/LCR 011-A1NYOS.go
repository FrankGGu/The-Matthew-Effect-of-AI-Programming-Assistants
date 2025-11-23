func findMaxLength(nums []int) int {
    countMap := make(map[int]int)
    countMap[0] = -1
    maxLength, count := 0, 0

    for i, num := range nums {
        if num == 0 {
            count--
        } else {
            count++
        }

        if idx, exists := countMap[count]; exists {
            maxLength = max(maxLength, i-idx)
        } else {
            countMap[count] = i
        }
    }

    return maxLength
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}