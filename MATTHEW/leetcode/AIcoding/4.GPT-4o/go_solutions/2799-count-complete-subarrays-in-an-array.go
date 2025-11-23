func countCompleteSubarrays(nums []int) int {
    n := len(nums)
    uniqueCount := make(map[int]int)
    for _, num := range nums {
        uniqueCount[num]++
    }
    totalUnique := len(uniqueCount)

    count := 0
    for start := 0; start < n; start++ {
        seen := make(map[int]int)
        for end := start; end < n; end++ {
            seen[nums[end]]++
            if len(seen) == totalUnique {
                count++
            }
        }
    }
    return count
}