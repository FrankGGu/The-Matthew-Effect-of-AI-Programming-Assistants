func minOperations(nums []int) int {
    maxCount := 0
    countMap := make(map[int]int)

    for _, num := range nums {
        countMap[num]++
        if countMap[num] > maxCount {
            maxCount = countMap[num]
        }
    }

    return len(nums) - maxCount
}