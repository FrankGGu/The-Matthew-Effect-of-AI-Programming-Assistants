func maxDistance(arrays [][]int) int {
    minVal := arrays[0][0]
    maxVal := arrays[0][len(arrays[0])-1]
    res := 0

    for i := 1; i < len(arrays); i++ {
        currentMin := arrays[i][0]
        currentMax := arrays[i][len(arrays[i])-1]
        res = max(res, max(maxVal - currentMin, currentMax - minVal))
        minVal = min(minVal, currentMin)
        maxVal = max(maxVal, currentMax)
    }

    return res
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