package main

func stoneGameIX(stones []int) bool {
    count := make([]int, 3)
    for _, s := range stones {
        count[s%3]++
    }
    if count[1] == 0 || count[2] == 0 {
        return false
    }
    if count[1] == count[2] {
        return false
    }
    return true
}