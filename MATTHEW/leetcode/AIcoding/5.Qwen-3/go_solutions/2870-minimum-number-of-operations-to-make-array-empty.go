package main

func minOperations(nums []int) int {
    count := make(map[int]int)
    for _, num := range nums {
        count[num]++
    }

    res := 0
    for _, v := range count {
        if v == 1 {
            return -1
        }
        res += v / 3
        if v%3 != 0 {
            res++
        }
    }
    return res
}