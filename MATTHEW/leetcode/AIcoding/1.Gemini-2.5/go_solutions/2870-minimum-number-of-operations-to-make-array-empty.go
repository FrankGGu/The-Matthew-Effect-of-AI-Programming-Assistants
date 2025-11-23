func minOperations(nums []int) int {
    counts := make(map[int]int)
    for _, num := range nums {
        counts[num]++
    }

    totalOperations := 0
    for _, count := range counts {
        if count == 1 {
            return -1
        }