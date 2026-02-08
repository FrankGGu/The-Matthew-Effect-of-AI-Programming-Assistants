package main

func countElements(nums []int) int {
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
    count := 0
    for _, num := range nums {
        if num > minVal && num < maxVal {
            count++
        }
    }
    return count
}