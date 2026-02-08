package main

func maxValueAfterIncrementingSubarrays(length int, updates []int) int {
    arr := make([]int, length)
    for _, update := range updates {
        start, end := 0, update-1
        if start >= length {
            continue
        }
        if end >= length {
            end = length - 1
        }
        arr[start]++
        if end+1 < length {
            arr[end+1]--
        }
    }
    max := 0
    current := 0
    for _, val := range arr {
        current += val
        if current > max {
            max = current
        }
    }
    return max
}