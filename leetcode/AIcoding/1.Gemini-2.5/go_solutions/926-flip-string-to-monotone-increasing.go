func minFlipsMonoIncr(s string) int {
    n := len(s)
    if n == 0 {
        return 0
    }

    // `flips` initially stores the count of '0's in the entire string.
    // This represents the cost if the entire string were to become '1's (e.g., "000" -> "111" needs 3 flips).
    flips := 0
    for _, char := range s {
        if char == '0' {
            flips++
        }
    }

    minFlips := flips // Initialize with the cost of making the whole string '1's.

    // `prefixOnes` stores the count of '1's encountered so far in the prefix.
    prefixOnes := 0

    // Iterate through all possible split points 'i'.
    // 'i' represents the first index that should be '1'.
    // So, s[0...i-1] should be '0's, and s[i...n-1] should be '1's.
    for i := 0; i < n; i++ {
        // At this point, `prefixOnes` is the count of '1's in s[0...i-1].
        // `flips` is the count of '0's in s[i...n-1].
        // The current cost for this split point 'i' is `prefixOnes + flips`.
        if prefixOnes + flips < minFlips {
            minFlips = prefixOnes + flips
        }

        // Update counts for the next iteration (split point i+1).
        if s[i] == '1' {
            prefixOnes++
        } else { // s[i] == '0'
            flips-- // This '0' is now part of the prefix that should be '0's.
                    // So, it's no longer a '0' in the suffix that needs to be flipped to '1'.
        }
    }

    // After the loop, `prefixOnes` will contain the total count of '1's in the string.
    // `flips` will be 0 (all '0's have been processed and removed from suffix count).
    // This represents the case where the entire string becomes '0's (e.g., "111" -> "000" needs 3 flips).
    // The cost is `prefixOnes` (total '1's) + 0 (suffix '0's).
    if prefixOnes < minFlips {
        minFlips = prefixOnes
    }

    return minFlips
}