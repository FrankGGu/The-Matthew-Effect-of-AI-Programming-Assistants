package main

func largestAltitude(operations []string) int {
    maxAlt := 0
    currentAlt := 0
    for _, op := range operations {
        if op == "X++" {
            currentAlt++
        } else if op == "X--" {
            currentAlt--
        }
        if currentAlt > maxAlt {
            maxAlt = currentAlt
        }
    }
    return maxAlt
}