package main

func smallestRangeII(nums []int, k int) int {
    sort.Ints(nums)
    n := len(nums)
    minRange := nums[n-1] - nums[0]
    for i := 0; i < n-1; i++ {
        if nums[i+1]-nums[i] <= 2*k {
            continue
        }
        currentMin := nums[0] + k
        currentMax := nums[i] + k
        nextMin := nums[i+1] - k
        nextMax := nums[n-1] - k
        minRange = min(minRange, max(currentMax, nextMax) - min(currentMin, nextMin))
    }
    return minRange
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}