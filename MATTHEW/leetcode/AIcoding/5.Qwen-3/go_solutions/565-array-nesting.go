package main

func arrayNesting(nums []int) int {
    maxLen := 0
    visited := make([]bool, len(nums))

    for i := 0; i < len(nums); i++ {
        if !visited[i] {
            start := i
            count := 0
            for !visited[start] {
                visited[start] = true
                start = nums[start]
                count++
            }
            if count > maxLen {
                maxLen = count
            }
        }
    }

    return maxLen
}