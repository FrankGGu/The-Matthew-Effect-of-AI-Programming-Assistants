package main

func minCostToRemoveElements(nums []int, x int) int {
    n := len(nums)
    cost := make([]int, n)
    for i := 0; i < n; i++ {
        cost[i] = nums[i]
    }
    for i := 1; i < n; i++ {
        if nums[i] < nums[i-1] {
            cost[i] = cost[i-1] + nums[i]
        } else {
            cost[i] = cost[i-1]
        }
    }
    return cost[n-1]
}