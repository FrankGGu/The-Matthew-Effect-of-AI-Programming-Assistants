package main

func transformArray(n int, ans []int) []int {
    if n == 0 {
        return ans
    }
    res := make([]int, n)
    for i := 0; i < n; i++ {
        left := 0
        if i > 0 {
            left = ans[i-1]
        }
        right := 0
        if i < n-1 {
            right = ans[i+1]
        }
        res[i] = left + right
    }
    return res
}