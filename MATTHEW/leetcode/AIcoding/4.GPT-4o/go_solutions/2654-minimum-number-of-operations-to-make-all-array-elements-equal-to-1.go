func minOperations(nums []int) int {
    maxCount := 0
    count := make(map[int]int)

    for _, num := range nums {
        count[num]++
        if count[num] > maxCount {
            maxCount = count[num]
        }
    }

    return len(nums) - maxCount
}