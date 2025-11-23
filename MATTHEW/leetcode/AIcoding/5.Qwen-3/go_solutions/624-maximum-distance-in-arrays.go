package main

func maximumDistance(arrays [][]int) int {
    minVal := arrays[0][0]
    maxVal := arrays[0][len(arrays[0])-1]
    result := 0

    for i := 1; i < len(arrays); i++ {
        currentMin := arrays[i][0]
        currentMax := arrays[i][len(arrays[i])-1]

        result = max(result, abs(currentMax-minVal), abs(maxVal-currentMin))

        if currentMin < minVal {
            minVal = currentMin
        }
        if currentMax > maxVal {
            maxVal = currentMax
        }
    }

    return result
}

func max(a, b int) int {
    if a > b {
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