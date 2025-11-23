package main

import "math"

func minNumberOfFrogs(croakOfFrogs string) int {
    cCount := 0
    rCount := 0
    oCount := 0
    aCount := 0
    kCount := 0

    maxFrogs := 0
    currentFrogs := 0

    for _, char := range croakOfFrogs {
        switch char {
        case 'c':
            cCount++
            currentFrogs++
            maxFrogs = int(math.Max(float64(maxFrogs), float64(currentFrogs)))
        case 'r':
            rCount++
            if rCount > cCount {
                return -1
            }
        case 'o':
            oCount++
            if oCount > rCount {
                return -1
            }
        case 'a':
            aCount++
            if aCount > oCount {
                return -1
            }
        case 'k':
            kCount++
            if kCount > aCount {
                return -1
            }
            currentFrogs--
        default:
            return -1 // Invalid character
        }
    }

    if cCount != kCount || rCount != kCount || oCount != kCount || aCount != kCount {
        return -1
    }

    return maxFrogs
}