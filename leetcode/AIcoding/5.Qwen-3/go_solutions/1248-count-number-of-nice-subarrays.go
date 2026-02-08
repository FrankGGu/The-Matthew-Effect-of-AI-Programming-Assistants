package main

func numberOfSubarrays(nums []int, k int) int {
    count := make(map[int]int)
    count[0] = 1
    res := 0
    prefix := 0
    for _, num := range nums {
        prefix += num % 2
        res += count[prefix-k]
        count[prefix]++
    }
    return res
}