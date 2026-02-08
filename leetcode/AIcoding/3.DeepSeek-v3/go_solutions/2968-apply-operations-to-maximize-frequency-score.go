func maxFrequencyScore(nums []int, k int) int {
    sort.Ints(nums)
    n := len(nums)
    prefix := make([]int, n+1)
    for i := 0; i < n; i++ {
        prefix[i+1] = prefix[i] + nums[i]
    }

    max := 0
    left := 0
    for right := 0; right < n; right++ {
        for (nums[right]*(right-left+1)-(prefix[right+1]-prefix[left])) > k {
            left++
        }
        if right-left+1 > max {
            max = right - left + 1
        }
    }
    return max
}