package main

func sumCounts(nums []int) int {
    n := len(nums)
    result := 0
    for i := 0; i < n; i++ {
        seen := make(map[int]bool)
        count := 0
        for j := i; j < n; j++ {
            if !seen[nums[j]] {
                seen[nums[j]] = true
                count++
            }
            result += count * count
        }
    }
    return result
}