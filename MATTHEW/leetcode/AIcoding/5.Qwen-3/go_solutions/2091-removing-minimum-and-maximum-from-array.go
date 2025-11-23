package main

func removeAlmostEqualFromArray(nums []int) int {
    n := len(nums)
    if n <= 2 {
        return 0
    }
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
    countMin := 0
    countMax := 0
    for _, num := range nums {
        if num == minVal {
            countMin++
        }
        if num == maxVal {
            countMax++
        }
    }
    if minVal == maxVal {
        return n - 1
    }
    return n - countMin - countMax
}