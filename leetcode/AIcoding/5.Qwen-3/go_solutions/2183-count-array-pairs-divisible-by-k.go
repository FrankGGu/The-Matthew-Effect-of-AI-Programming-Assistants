package main

func countPairs(nums []int, k int) int {
    modCount := make(map[int]int)
    result := 0
    for _, num := range nums {
        mod := num % k
        complement := (k - mod) % k
        result += modCount[complement]
        modCount[mod]++
    }
    return result
}