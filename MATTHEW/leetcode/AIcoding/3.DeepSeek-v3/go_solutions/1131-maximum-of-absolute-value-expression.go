func maxAbsValExpr(arr1 []int, arr2 []int) int {
    n := len(arr1)
    max1, max2, max3, max4 := -1 << 31, -1 << 31, -1 << 31, -1 << 31
    min1, min2, min3, min4 := 1 << 31, 1 << 31, 1 << 31, 1 << 31

    for i := 0; i < n; i++ {
        val1 := arr1[i] + arr2[i] + i
        val2 := arr1[i] + arr2[i] - i
        val3 := arr1[i] - arr2[i] + i
        val4 := arr1[i] - arr2[i] - i
        if val1 > max1 {
            max1 = val1
        }
        if val1 < min1 {
            min1 = val1
        }
        if val2 > max2 {
            max2 = val2
        }
        if val2 < min2 {
            min2 = val2
        }
        if val3 > max3 {
            max3 = val3
        }
        if val3 < min3 {
            min3 = val3
        }
        if val4 > max4 {
            max4 = val4
        }
        if val4 < min4 {
            min4 = val4
        }
    }

    diff1 := max1 - min1
    diff2 := max2 - min2
    diff3 := max3 - min3
    diff4 := max4 - min4

    maxDiff := diff1
    if diff2 > maxDiff {
        maxDiff = diff2
    }
    if diff3 > maxDiff {
        maxDiff = diff3
    }
    if diff4 > maxDiff {
        maxDiff = diff4
    }

    return maxDiff
}