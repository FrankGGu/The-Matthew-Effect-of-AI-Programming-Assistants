func maxFrequency(nums []int, k int) int {
    sort.Ints(nums)
    left, total, maxFreq := 0, 0, 0

    for right := 0; right < len(nums); right++ {
        total += nums[right]
        for nums[right]*(right-left+1) > total+k {
            total -= nums[left]
            left++
        }
        if right-left+1 > maxFreq {
            maxFreq = right - left + 1
        }
    }
    return maxFreq
}