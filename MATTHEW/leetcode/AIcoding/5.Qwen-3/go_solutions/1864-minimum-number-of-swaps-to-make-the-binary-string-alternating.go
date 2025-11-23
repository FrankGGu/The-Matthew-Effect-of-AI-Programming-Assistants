package main

func minSwapsToMakeBinaryStringAlternating(s string) int {
    evenCount := 0
    oddCount := 0
    for i, c := range s {
        if i%2 == 0 {
            if c == '1' {
                evenCount++
            }
        } else {
            if c == '1' {
                oddCount++
            }
        }
    }

    if len(s)%2 == 0 {
        return min(evenCount, oddCount)
    } else {
        if evenCount == oddCount+1 {
            return oddCount
        } else if oddCount == evenCount+1 {
            return evenCount
        } else {
            return -1
        }
    }
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}