package main

func numberOfWays(nums []int) int {
    total := 0
    for _, num := range nums {
        total += num
    }
    leftSum := 0
    count := 0
    for i := 0; i < len(nums)-1; i++ {
        leftSum += nums[i]
        rightSum := total - leftSum
        if leftSum == rightSum {
            count++
        }
    }
    return count
}