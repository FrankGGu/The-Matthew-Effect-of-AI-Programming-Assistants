func maxAbsValExpr(arr1 []int, arr2 []int) int {
    n := len(arr1)
    maxVal := 0
    for i := 0; i < 4; i++ {
        a, b := 1, 1
        if i&1 == 1 {
            a = -1
        }
        if i&2 == 2 {
            b = -1
        }
        currentMax := 0
        for j := 0; j < n; j++ {
            currentMax = max(currentMax, a*arr1[j]+b*arr2[j]+j)
        }
        for j := 0; j < n; j++ {
            currentMax = max(currentMax, a*arr1[j]+b*arr2[j]-j)
        }
        maxVal = max(maxVal, currentMax)
    }
    return maxVal
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}