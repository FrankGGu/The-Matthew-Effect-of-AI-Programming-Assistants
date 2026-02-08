func subarraysWithKDistinct(nums []int, k int) int {
    return atMostK(nums, k) - atMostK(nums, k-1)
}

func atMostK(nums []int, k int) int {
    count := 0
    freq := make(map[int]int)
    left := 0
    for right := 0; right < len(nums); right++ {
        if freq[nums[right]] == 0 {
            k--
        }
        freq[nums[right]]++
        for k < 0 {
            freq[nums[left]]--
            if freq[nums[left]] == 0 {
                k++
            }
            left++
        }
        count += right - left + 1
    }
    return count
}