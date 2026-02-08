package main

func minFlips(s string) int {
    n := len(s)
    if n == 0 {
        return 0
    }
    // Two possible target patterns: starts with '0' or '1'
    // For even positions, expected char is '0' for pattern0 and '1' for pattern1
    // For odd positions, expected char is '1' for pattern0 and '0' for pattern1
    // We will count the number of flips needed for both patterns

    count0 := 0 // flips needed to make string start with '0'
    count1 := 0 // flips needed to make string start with '1'

    for i := 0; i < n; i++ {
        if i%2 == 0 {
            if s[i] != '0' {
                count0++
            }
            if s[i] != '1' {
                count1++
            }
        } else {
            if s[i] != '1' {
                count0++
            }
            if s[i] != '0' {
                count1++
            }
        }
    }

    // If the length is even, the two patterns are valid
    if n%2 == 0 {
        return min(count0, count1)
    }

    // If the length is odd, we need to consider that the pattern can only be valid if it starts with '0' or '1'
    // So, we need to compare the minimum between count0 and count1
    return min(count0, count1)
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}