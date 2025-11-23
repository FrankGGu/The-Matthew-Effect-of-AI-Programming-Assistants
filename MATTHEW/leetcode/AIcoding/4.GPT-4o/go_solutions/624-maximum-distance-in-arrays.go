func maxDistance(arrays [][]int) int {
    min1, max1 := arrays[0][0], arrays[0][len(arrays[0])-1]
    maxDist := 0

    for i := 1; i < len(arrays); i++ {
        maxDist = max(maxDist, abs(arrays[i][0]-max1))
        maxDist = max(maxDist, abs(arrays[i][len(arrays[i])-1]-min1))
        min1 = min(min1, arrays[i][0])
        max1 = max(max1, arrays[i][len(arrays[i])-1])
    }

    return maxDist
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}