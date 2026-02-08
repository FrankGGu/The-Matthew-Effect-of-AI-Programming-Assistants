package main

func numOfSubarrays(nums []int, k int, threshold int) int {
    n := len(nums)
    if k > n {
        return 0
    }
    sum := 0
    for i := 0; i < k; i++ {
        sum += nums[i]
    }
    count := 0
    if sum >= threshold*k {
        count++
    }
    for i := k; i < n; i++ {
        sum += nums[i] - nums[i-k]
        if sum >= threshold*k {
            count++
        }
    }
    return count
}