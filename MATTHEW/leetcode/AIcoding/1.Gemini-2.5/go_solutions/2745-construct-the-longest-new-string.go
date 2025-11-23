package main

import "math"

func longestString(x int, y int, z int) int {
    minXY := int(math.Min(float64(x), float64(y)))

    // Calculate the number of AA/BB pairs that can be used in an alternating fashion.
    // We can always use 2 * min(x, y) pairs (e.g., AABB... or BBAA...).
    // If x != y, we can add one more pair of the more abundant type (e.g., AABBAA if x > y).
    // So, if x == y, we use 2 * x pairs.
    // If x != y, we use 2 * min(x, y) + 1 pairs.

    numAlternatingPairs := 0
    if x == y {
        numAlternatingPairs = 2 * minXY
    } else {
        numAlternatingPairs = 2 * minXY + 1
    }

    // Each pair (AA, BB, or AB) contributes 2 characters to the string length.
    // The total length is (number of alternating AA/BB pairs + number of AB pairs) * 2.

    totalLength := (numAlternatingPairs + z) * 2

    return totalLength
}