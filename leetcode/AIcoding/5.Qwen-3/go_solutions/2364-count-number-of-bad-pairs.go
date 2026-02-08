package main

func numIdenticalPairs(nums []int) int {
    count := make(map[int]int)
    result := 0
    for _, num := range nums {
        result += count[num]
        count[num]++
    }
    return result
}