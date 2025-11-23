package main

func numRabbits(blooms []int) int {
    m := make(map[int]int)
    for _, b := range blooms {
        m[b]++
    }
    res := 0
    for k, v := range m {
        groupSize := k + 1
        groups := (v + groupSize - 1) / groupSize
        res += groups * groupSize
    }
    return res
}