func maxDist(points [][]int) int {
    max1, min1 := -1 << 31, 1 << 31 - 1
    max2, min2 := -1 << 31, 1 << 31 - 1

    for _, p := range points {
        sum := p[0] + p[1]
        diff := p[0] - p[1]

        if sum > max1 {
            max1 = sum
        }
        if sum < min1 {
            min1 = sum
        }
        if diff > max2 {
            max2 = diff
        }
        if diff < min2 {
            min2 = diff
        }
    }

    return max(max1 - min1, max2 - min2)
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}