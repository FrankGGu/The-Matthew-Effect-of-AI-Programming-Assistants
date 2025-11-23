func numWays(s string) int {
    n := len(s)

    onesIndices := []int{}
    for i, char := range s {
        if char == '1' {
            onesIndices = append(onesIndices, i)
        }
    }

    totalOnes := len(onesIndices)

    if totalOnes%3 != 0 {
        return 0
    }

    // Case 1: All zeros
    if totalOnes == 0 {
        // We need to split into 3 non-empty parts.
        // This requires at least 3 characters.
        if n < 3 {
            return 0
        }
        // Number of ways to choose 2 split points from n-1 possible positions.
        // C(n-1, 2) = (n-1) * (n-2) / 2
        return (n - 1) * (n - 2) / 2
    }

    // Case 2: totalOnes > 0 and divisible by 3
    // Each part must have targetOnes number of '1's.
    targetOnes := totalOnes / 3

    // Calculate the number of ways to make the first cut.
    // The first part s1 must contain exactly `targetOnes` '1's.
    // This means the first cut must be made after the `targetOnes`-th '1'
    // and before the `(targetOnes + 1)`-th '1'.
    // `onesIndices[targetOnes-1]` is the 0-based index of the `targetOnes`-th '1'.
    // `onesIndices[targetOnes]` is the 0-based index of the `(targetOnes + 1)`-th '1'.
    // The number of possible cut positions is the difference between these indices.
    ways1 := onesIndices[targetOnes] - onesIndices[targetOnes-1]

    // Calculate the number of ways to make the second cut.
    // The first two parts (s1 + s2) combined must contain exactly `2 * targetOnes` '1's.
    // This means the second cut must be made after the `(2 * targetOnes)`-th '1'
    // and before the `(2 * targetOnes + 1)`-th '1'.
    // `onesIndices[2*targetOnes-1]` is the 0-based index of the `(2*targetOnes)`-th '1'.
    // `onesIndices[2*targetOnes]` is the 0-based index of the `(2*targetOnes + 1)`-th '1'.
    // The number of possible cut positions is the difference between these indices.
    ways2 := onesIndices[2*targetOnes] - onesIndices[2*targetOnes-1]

    // The total number of ways to split the string is the product of the ways
    // to make the first and second cuts.
    return ways1 * ways2
}