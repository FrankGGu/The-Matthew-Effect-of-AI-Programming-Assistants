package main

func countInterestingSubarrays(nums []int, k int) int {
    count := make(map[int]int)
    count[0] = 1
    result := 0
    current := 0
    for _, num := range nums {
        current = (current + num) % k
        result += count[(current - k + k) % k]
        count[current]++
    }
    return result
}