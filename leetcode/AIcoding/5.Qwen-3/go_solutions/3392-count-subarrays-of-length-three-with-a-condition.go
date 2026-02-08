package main

func numberOfSubarrays(nums []int, k int) int {
    count := make(map[int]int)
    count[0] = 1
    res := 0
    prefix := 0
    for _, num := range nums {
        prefix += num % 2
        if val, ok := count[prefix-k]; ok {
            res += val
        }
        count[prefix]++
    }
    return res
}