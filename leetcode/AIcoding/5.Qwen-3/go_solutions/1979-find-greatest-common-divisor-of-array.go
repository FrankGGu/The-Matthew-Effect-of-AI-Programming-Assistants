package main

func findGCD(nums []int) int {
    minVal := nums[0]
    maxVal := nums[0]
    for _, num := range nums {
        if num < minVal {
            minVal = num
        }
        if num > maxVal {
            maxVal = num
        }
    }
    for minVal != 0 {
        temp := minVal
        minVal = maxVal % minVal
        maxVal = temp
    }
    return maxVal
}