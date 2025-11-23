func maxAbsValExpr(arr1 []int, arr2 []int) int {
    max1, min1 := -1 << 30, 1 << 30
    max2, min2 := -1 << 30, 1 << 30
    max3, min3 := -1 << 30, 1 << 30
    max4, min4 := -1 << 30, 1 << 30
    for i := 0; i < len(arr1); i++ {
        x, y := arr1[i], arr2[i]
        max1 = max(max1, x+y+i)
        min1 = min(min1, x+y+i)
        max2 = max(max2, x+y-i)
        min2 = min(min2, x+y-i)
        max3 = max(max3, x-y+i)
        min3 = min(min3, x-y+i)
        max4 = max(max4, x-y-i)
        min4 = min(min4, x-y-i)
    }
    ans := max(max1-min1, max2-min2)
    ans = max(ans, max3-min3)
    ans = max(ans, max4-min4)
    return ans
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