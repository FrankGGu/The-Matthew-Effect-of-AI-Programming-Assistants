func findMaxLength(nums []int) int {
    count := 0
    maxLen := 0
    countMap := make(map[int]int)
    countMap[0] = -1

    for i, num := range nums {
        if num == 0 {
            count--
        } else {
            count++
        }
        if idx, ok := countMap[count]; ok {
            if i-idx > maxLen {
                maxLen = i - idx
            }
        } else {
            countMap[count] = i
        }
    }
    return maxLen
}