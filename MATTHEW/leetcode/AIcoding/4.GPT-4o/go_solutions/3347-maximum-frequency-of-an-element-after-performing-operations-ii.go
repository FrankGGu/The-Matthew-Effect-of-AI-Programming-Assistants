func maxFrequency(nums []int, k int) int {
    sort.Ints(nums)
    left, total, result := 0, 0, 0

    for right := 0; right < len(nums); right++ {
        total += nums[right]

        for nums[right]*(right-left+1) > total+k {
            total -= nums[left]
            left++
        }

        result = max(result, right-left+1)
    }

    return result
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}