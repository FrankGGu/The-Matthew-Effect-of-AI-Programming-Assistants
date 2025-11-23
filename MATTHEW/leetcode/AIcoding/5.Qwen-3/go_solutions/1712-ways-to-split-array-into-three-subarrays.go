package main

func numSubarraysWithKWins(nums []int, k int) int {
    n := len(nums)
    prefixSum := make([]int, n+1)
    for i := 0; i < n; i++ {
        prefixSum[i+1] = prefixSum[i] + nums[i]
    }

    result := 0
    left := 0
    for right := 0; right < n; right++ {
        if prefixSum[right+1]-prefixSum[left] >= k {
            for left <= right && prefixSum[right+1]-prefixSum[left] >= k {
                left++
            }
            result += left
        }
    }
    return result
}

func numberOfWays(nums []int, k int) int {
    return numSubarraysWithKWins(nums, k)
}