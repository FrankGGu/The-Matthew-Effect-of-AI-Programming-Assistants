package main

func isSplitPossible(arr []int, m int) bool {
    n := len(arr)
    prefix := make([]int, n+1)
    for i := 0; i < n; i++ {
        prefix[i+1] = prefix[i] + arr[i]
    }
    for i := 0; i < n-1; i++ {
        if prefix[i+1] >= m && prefix[n] - prefix[i+1] >= m {
            return true
        }
    }
    return false
}