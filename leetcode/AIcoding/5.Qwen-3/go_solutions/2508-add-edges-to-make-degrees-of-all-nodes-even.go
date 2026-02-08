package main

func findGCD(nums []int) int {
    minVal, maxVal := nums[0], nums[0]
    for _, num := range nums {
        if num < minVal {
            minVal = num
        }
        if num > maxVal {
            maxVal = num
        }
    }
    for i := minVal; i >= 1; i-- {
        if minVal%i == 0 && maxVal%i == 0 {
            return i
        }
    }
    return 1
}