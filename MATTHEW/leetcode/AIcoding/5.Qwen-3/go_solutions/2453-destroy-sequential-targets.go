package main

func findBestTarget(nums []int, space int) int {
    maxCount := 0
    result := nums[0]
    countMap := make(map[int]int)

    for _, num := range nums {
        key := num % space
        countMap[key]++
        if countMap[key] > maxCount {
            maxCount = countMap[key]
            result = num
        } else if countMap[key] == maxCount && num < result {
            result = num
        }
    }

    return result
}