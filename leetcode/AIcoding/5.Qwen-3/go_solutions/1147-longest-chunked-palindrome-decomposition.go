package main

func longestDecomposition(s string) int {
    n := len(s)
    left := 0
    right := n - 1
    res := 0
    for left <= right {
        found := false
        for i := 1; left + i <= right; i++ {
            if s[left:left+i] == s[right-i+1:right+1] {
                res++
                left += i
                right -= i
                found = true
                break
            }
        }
        if !found {
            return res
        }
    }
    return res
}