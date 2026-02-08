package main

func maxAbsValExpr(arr1 []int, arr2 []int) int {
    maxVal := 0
    n := len(arr1)
    for i := 0; i < n; i++ {
        for j := i + 1; j < n; j++ {
            current := abs(arr1[i] - arr1[j]) + abs(arr2[i] - arr2[j])
            if current > maxVal {
                maxVal = current
            }
        }
    }
    return maxVal
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}