package main

func minIncrementToMakeArrayUnique(nums []int) int {
    count := make(map[int]int)
    res := 0
    for _, num := range nums {
        if count[num] > 0 {
            res += count[num]
            count[num+1] += count[num]
        }
        count[num]++
    }
    return res
}