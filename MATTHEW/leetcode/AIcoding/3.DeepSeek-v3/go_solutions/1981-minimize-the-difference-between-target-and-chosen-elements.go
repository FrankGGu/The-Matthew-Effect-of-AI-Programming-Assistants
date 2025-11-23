func minimizeTheDifference(mat [][]int, target int) int {
    m := len(mat)
    n := len(mat[0])

    possibleSums := make(map[int]bool)
    possibleSums[0] = true

    for i := 0; i < m; i++ {
        newSums := make(map[int]bool)
        minRow := math.MaxInt32
        for j := 0; j < n; j++ {
            if mat[i][j] > minRow {
                continue
            }
            minRow = mat[i][j]
            for sum := range possibleSums {
                newSum := sum + mat[i][j]
                if newSum <= 2*target {
                    newSums[newSum] = true
                }
            }
        }
        possibleSums = newSums
    }

    minDiff := math.MaxInt32
    for sum := range possibleSums {
        diff := abs(sum - target)
        if diff < minDiff {
            minDiff = diff
        }
    }
    return minDiff
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}