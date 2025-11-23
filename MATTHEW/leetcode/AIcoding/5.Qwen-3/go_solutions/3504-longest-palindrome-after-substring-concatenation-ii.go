package main

func longestDecomposition(s string) int {
    n := len(s)
    left, right := 0, n-1
    res := 0
    for left <= right {
        if s[left] == s[right] {
            i, j := left, right
            for i < j && s[i] == s[j] {
                i++
                j--
            }
            if i >= j {
                res++
                break
            }
        }
        left++
        right--
    }
    return res
}