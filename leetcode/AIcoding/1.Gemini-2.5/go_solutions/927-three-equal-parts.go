func threeEqualParts(arr []int) []int {
    n := len(arr)
    totalOnes := 0
    for _, x := range arr {
        totalOnes += x
    }

    if totalOnes == 0 {
        // If all zeros, any valid split works.
        // The problem requires 0