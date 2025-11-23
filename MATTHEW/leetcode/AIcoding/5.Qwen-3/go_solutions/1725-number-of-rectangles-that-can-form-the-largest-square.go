package main

func numRabbits(arr []int) int {
    count := make(map[int]int)
    for _, x := range arr {
        count[x]++
    }
    res := 0
    for k, v := range count {
        if v%k == 0 {
            res += v
        } else {
            res += (v/k + 1) * k
        }
    }
    return res
}