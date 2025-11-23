package main

func largestAltitude(gain []int) int {
    maxAlt := 0
    currentAlt := 0
    for _, g := range gain {
        currentAlt += g
        if currentAlt > maxAlt {
            maxAlt = currentAlt
        }
    }
    return maxAlt
}