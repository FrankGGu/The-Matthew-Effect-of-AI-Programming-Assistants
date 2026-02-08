package main

func countPrefixes(nums []int, k int) int {
    count := 0
    prefix := make(map[int]bool)
    for i := 0; i < len(nums); i++ {
        num := nums[i]
        prefix[num] = true
        if len(prefix) == k {
            count++
        }
    }
    return count
}