package main

func uniqueOccurrences(nums []int) bool {
    count := make(map[int]int)
    for _, num := range nums {
        count[num]++
    }

    seen := make(map[int]bool)
    for _, v := range count {
        if seen[v] {
            return false
        }
        seen[v] = true
    }
    return true
}