package main

func longestMountain(A []int) int {
    n := len(A)
    if n < 3 {
        return 0
    }
    maxLen := 0
    up := make([]int, n)
    down := make([]int, n)
    for i := 1; i < n; i++ {
        if A[i] > A[i-1] {
            up[i] = up[i-1] + 1
        }
    }
    for i := n - 2; i >= 0; i-- {
        if A[i] > A[i+1] {
            down[i] = down[i+1] + 1
        }
    }
    for i := 0; i < n; i++ {
        if up[i] > 0 && down[i] > 0 {
            maxLen = max(maxLen, up[i]+down[i]+1)
        }
    }
    return maxLen
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}