package main

func findMaxK(nums []int) int {
    seen := make(map[int]bool)
    for _, num := range nums {
        seen[num] = true
    }
    maxK := -1
    for num := range seen {
        if num > 0 && seen[-num] {
            if num > maxK {
                maxK = num
            }
        }
    }
    return maxK
}