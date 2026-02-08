package main

func maximumElements(nums []int, limit int) int {
    count := make(map[int]int)
    for _, num := range nums {
        count[num]++
    }
    res := 0
    for k := range count {
        res += count[k]
    }
    return res
}