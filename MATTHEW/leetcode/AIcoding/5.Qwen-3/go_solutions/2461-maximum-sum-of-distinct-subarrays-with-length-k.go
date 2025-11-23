package main

func findMaximumSubarraySum(nums []int, k int) int {
    maxSum := 0
    currentSum := 0
    freq := make(map[int]int)

    for i := 0; i < len(nums); i++ {
        if i >= k {
            removed := nums[i-k]
            currentSum -= removed
            freq[removed]--
            if freq[removed] == 0 {
                delete(freq, removed)
            }
        }

        currentSum += nums[i]
        freq[nums[i]]++

        if i >= k-1 && len(freq) == k {
            if currentSum > maxSum {
                maxSum = currentSum
            }
        }
    }

    return maxSum
}