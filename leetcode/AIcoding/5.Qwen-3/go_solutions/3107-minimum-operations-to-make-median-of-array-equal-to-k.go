package main

func minOperations(nums []int, k int) int {
    sort.Ints(nums)
    n := len(nums)
    median := nums[n/2]
    if median == k {
        return 0
    }
    operations := 0
    for i := n / 2; i < n; i++ {
        if nums[i] < k {
            operations += k - nums[i]
        } else if nums[i] > k {
            operations += nums[i] - k
        }
    }
    return operations
}