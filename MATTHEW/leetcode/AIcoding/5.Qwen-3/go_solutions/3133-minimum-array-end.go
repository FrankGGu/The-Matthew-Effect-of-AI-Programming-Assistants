package main

func minArrayEnd(arr []int) int {
    n := len(arr)
    for i := 1; i < n; i++ {
        if arr[i] < arr[i-1] {
            return -1
        }
    }
    res := 0
    for i := 0; i < n; i++ {
        res |= arr[i]
    }
    return res
}