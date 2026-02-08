package main

func maxSubarraySum(nums []int, k int) int {
    n := len(nums)
    maxSum := 0
    currentSum := 0
    freq := make(map[int]int)

    for i := 0; i < n; i++ {
        currentSum += nums[i]
        if i >= k {
            removed := nums[i-k]
            currentSum -= removed
            freq[removed]--
            if freq[removed] == 0 {
                delete(freq, removed)
            }
        }

        if i >= k-1 {
            if len(freq) == 0 {
                maxSum = max(maxSum, currentSum)
            } else {
                maxSum = max(maxSum, currentSum)
            }
            freq[nums[i]]++
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