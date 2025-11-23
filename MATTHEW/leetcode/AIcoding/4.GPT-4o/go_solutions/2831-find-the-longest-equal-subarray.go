func longestEqualSubarray(nums []int, k int) int {
    left, maxLength, count := 0, 0, 0
    freq := make(map[int]int)

    for right := 0; right < len(nums); right++ {
        freq[nums[right]]++
        count = max(count, freq[nums[right]])

        for right-left+1-count > k {
            freq[nums[left]]--
            left++
        }

        maxLength = max(maxLength, right-left+1)
    }

    return maxLength
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}