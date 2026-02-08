package main

import "math"

func largestVariance(s string) int {
    maxVariance := 0

    // Iterate through all possible pairs of distinct characters (char1, char2)
    for char1Code := 'a'; char1Code <= 'z'; char1Code++ {
        for char2Code := 'a'; char2Code <= 'z'; char2Code++ {
            if char1Code == char2Code {
                continue
            }

            char1 := byte(char1Code)
            char2 := byte(char2Code)

            count1 := 0 // count of char1 in the current segment
            count2 := 0 // count of char2 in the current segment

            // This flag indicates if char2 has appeared in the current segment.
            // We only update maxVariance if char2 has appeared.
            hasChar2 := false 

            for i := 0; i < len(s); i++ {
                // If the character is neither char1 nor char2, skip it.
                // The segment continues, but counts don't change.
                if s[i] != char1 && s[i] != char2 {
                    continue
                }

                if s[i] == char1 {
                    count1++
                } else { // s[i] == char2
                    count2++
                    hasChar2 = true
                }

                // If char2 has appeared, update maxVariance.
                // This ensures that the substring contains at least one char2.
                if hasChar2 {
                    maxVariance = max(maxVariance, count1 - count2)
                }

                // Kadane's algorithm reset logic:
                // If count1 becomes less than count2, it means the current segment
                // has more char2s than char1s. This segment is no longer optimal
                // for maximizing (count1 - count2).
                // Resetting both counts effectively starts a new segment from the next character.
                // We also reset hasChar2 because the new segment starts fresh.
                if count1 < count2 {
                    count1 = 0
                    count2 = 0
                    hasChar2 = false
                }
            }
        }
    }

    return maxVariance
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}