package main

func partitionString(s string) int {
    seen := make(map[rune]int)
    count := 1
    for _, c := range s {
        if seen[c] > 0 {
            count++
            seen = make(map[rune]int)
        }
        seen[c]++
    }
    return count
}