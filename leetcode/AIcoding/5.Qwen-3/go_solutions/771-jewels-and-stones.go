package main

func numJewelsInStones(jewels string, stones string) int {
    jewelSet := make(map[rune]bool)
    for _, c := range jewels {
        jewelSet[c] = true
    }
    count := 0
    for _, c := range stones {
        if jewelSet[c] {
            count++
        }
    }
    return count
}