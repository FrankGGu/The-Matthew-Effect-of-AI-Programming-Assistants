package main

func smallestRangeI(nums []int, k int) int {
    minNum := nums[0]
    maxNum := nums[0]
    for _, num := range nums {
        if num < minNum {
            minNum = num
        }
        if num > maxNum {
            maxNum = num
        }
    }
    return max(0, maxNum-minNum-k)
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}