func countGood(nums []int, k int) int64 {
    freq := make(map[int]int)
    left := 0
    var res int64 = 0
    var pairs int = 0

    for right := 0; right < len(nums); right++ {
        pairs += freq[nums[right]]
        freq[nums[right]]++

        for pairs >= k {
            res += int64(len(nums) - right)
            pairs -= freq[nums[left]] - 1
            freq[nums[left]]--
            left++
        }
    }

    return res
}