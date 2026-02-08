package main

func minLengthAfterRemovals(s string) int {
    count := make(map[rune]int)
    for _, c := range s {
        count[c]++
    }
    maxCount := 0
    total := len(s)
    for _, v := range count {
        if v > maxCount {
            maxCount = v
        }
    }
    if maxCount > (total + 1)/2 {
        return 2*maxCount - total
    }
    return total % 2
}