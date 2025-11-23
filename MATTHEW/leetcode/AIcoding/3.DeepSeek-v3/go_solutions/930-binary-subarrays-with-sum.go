func numSubarraysWithSum(nums []int, goal int) int {
    prefix := make([]int, len(nums)+1)
    for i := 0; i < len(nums); i++ {
        prefix[i+1] = prefix[i] + nums[i]
    }

    count := 0
    freq := make(map[int]int)
    for _, sum := range prefix {
        count += freq[sum]
        freq[sum + goal]++
    }
    return count
}