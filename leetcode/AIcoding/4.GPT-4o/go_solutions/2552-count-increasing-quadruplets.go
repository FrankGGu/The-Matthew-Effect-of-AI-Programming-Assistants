func countQuadruplets(nums []int) int {
    n := len(nums)
    count := 0
    for k := 3; k < n; k++ {
        freq := make(map[int]int)
        for j := 0; j < k; j++ {
            freq[nums[j]]++
        }
        for i := 0; i < k; i++ {
            for x := nums[k] - nums[i]; x >= 1; x-- {
                count += freq[x]
            }
            freq[nums[i]]--
        }
    }
    return count
}