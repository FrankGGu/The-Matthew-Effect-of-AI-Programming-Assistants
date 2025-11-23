package main

func isGood(nums []int) bool {
    m := make(map[int]bool)
    for _, num := range nums {
        if num < 1 || num > len(nums)-1 {
            return false
        }
        if m[num] {
            return false
        }
        m[num] = true
    }
    return true
}