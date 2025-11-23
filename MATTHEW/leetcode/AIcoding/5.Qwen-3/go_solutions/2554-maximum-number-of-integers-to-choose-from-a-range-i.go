package main

func maxCount(nums []int, m int) int {
    seen := make(map[int]bool)
    for _, num := range nums {
        seen[num] = true
    }
    count := 0
    for i := 1; i <= m; i++ {
        if !seen[i] {
            count++
        }
    }
    return count
}