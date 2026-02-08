package main

func maximumNumberOfPairs(nums []int) int {
    count := make(map[int]int)
    for _, num := range nums {
        count[num]++
    }
    pairs := 0
    for _, v := range count {
        pairs += v / 2
    }
    return pairs
}