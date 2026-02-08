package main

func numJewelsInHarvest(J string, S string) int {
    jewelSet := make(map[rune]bool)
    for _, c := range J {
        jewelSet[c] = true
    }
    count := 0
    for _, c := range S {
        if jewelSet[c] {
            count++
        }
    }
    return count
}