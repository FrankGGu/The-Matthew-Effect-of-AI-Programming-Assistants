package main

func carPooling(nums [][]int, capacity int) bool {
    diff := make([]int, 1001)
    for _, trip := range nums {
        num, start, end := trip[0], trip[1], trip[2]
        diff[start] += num
        diff[end] -= num
    }
    current := 0
    for i := 0; i < 1001; i++ {
        current += diff[i]
        if current > capacity {
            return false
        }
    }
    return true
}