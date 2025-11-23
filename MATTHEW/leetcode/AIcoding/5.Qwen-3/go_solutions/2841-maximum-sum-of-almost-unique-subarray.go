package main

func maxSumSubarray(nums []int, k int) int {
    n := len(nums)
    if k > n {
        return 0
    }
    freq := make(map[int]int)
    sum := 0
    for i := 0; i < k; i++ {
        freq[nums[i]]++
        sum += nums[i]
    }
    maxSum := sum
    for i := k; i < n; i++ {
        left := nums[i-k]
        freq[left]--
        if freq[left] == 0 {
            delete(freq, left)
        }
        freq[nums[i]]++
        sum = sum - left + nums[i]
        if len(freq) < k {
            maxSum = max(maxSum, sum)
        }
    }
    return maxSum
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}