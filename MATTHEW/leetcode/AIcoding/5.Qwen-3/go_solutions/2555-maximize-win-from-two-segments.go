package main

func maxOperations(s string) int {
    n := len(s)
    left := make([]int, n)
    right := make([]int, n)

    count := 0
    for i := 0; i < n; i++ {
        if s[i] == ']' {
            count--
        } else {
            count++
        }
        left[i] = count
    }

    count = 0
    for i := n - 1; i >= 0; i-- {
        if s[i] == '[' {
            count--
        } else {
            count++
        }
        right[i] = count
    }

    res := 0
    for i := 0; i < n-1; i++ {
        if s[i] == ']' && s[i+1] == '[' {
            res = max(res, left[i]+right[i+1])
        }
    }

    return res
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}