func subarraySum(nums []int, k int) int {
    count := 0
    currentSum := 0
    prefixSumCount := make(map[int]int)
    prefixSumCount[0] = 1

    for _, num := range nums {
        currentSum += num
        if freq, ok := prefixSumCount[currentSum-k]; ok {
            count += freq
        }
        prefixSumCount[currentSum]++
    }

    return count
}