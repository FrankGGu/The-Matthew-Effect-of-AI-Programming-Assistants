func longestSubarray(nums []int, k int) int {
    count := make(map[int]int)
    left, maxLength := 0, 0

    for right := 0; right < len(nums); right++ {
        count[nums[right]]++

        for len(count) > k {
            count[nums[left]]--
            if count[nums[left]] == 0 {
                delete(count, nums[left])
            }
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