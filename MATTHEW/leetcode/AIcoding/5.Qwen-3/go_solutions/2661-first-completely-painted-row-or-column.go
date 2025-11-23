package main

func firstCompleteIndex(arr []int, count []int) int {
    mp := make(map[int]int)
    for i, num := range arr {
        mp[num]++
        if mp[num] == count[num-1] {
            return i
        }
    }
    return -1
}