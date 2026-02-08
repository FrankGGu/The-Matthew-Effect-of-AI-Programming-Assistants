package main

func maximumElementSum(nums []int) int {
    mp := make(map[int]int)
    for _, num := range nums {
        mp[num]++
    }
    res := 0
    for k := range mp {
        res += k
    }
    return res
}