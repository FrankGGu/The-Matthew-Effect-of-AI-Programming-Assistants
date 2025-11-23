package main

func waysToMakeFair(nums []int) int {
    n := len(nums)
    total := 0
    for i := 0; i < n; i++ {
        total += nums[i]
    }
    leftSum := 0
    count := 0
    for i := 0; i < n; i++ {
        rightSum := total - leftSum - nums[i]
        if leftSum == rightSum {
            count++
        }
        leftSum += nums[i]
    }
    return count
}