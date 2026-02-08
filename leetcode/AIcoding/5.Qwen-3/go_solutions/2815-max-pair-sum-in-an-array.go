package main

func maximumSum(arr []int) int {
    n := len(arr)
    if n < 2 {
        return 0
    }
    max1 := -1 << 63
    max2 := -1 << 63
    for i := 0; i < n; i++ {
        if arr[i] > max1 {
            max2 = max1
            max1 = arr[i]
        } else if arr[i] > max2 {
            max2 = arr[i]
        }
    }
    if max1 == max2 {
        return max1 * 2
    }
    return max1 + max2
}