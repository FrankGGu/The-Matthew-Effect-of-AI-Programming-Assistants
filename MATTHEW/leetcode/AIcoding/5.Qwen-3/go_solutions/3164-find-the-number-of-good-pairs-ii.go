package main

func numIdenticalPairs(nums []int) int {
    count := 0
    freq := make(map[int]int)
    for _, num := range nums {
        count += freq[num]
        freq[num]++
    }
    return count
}