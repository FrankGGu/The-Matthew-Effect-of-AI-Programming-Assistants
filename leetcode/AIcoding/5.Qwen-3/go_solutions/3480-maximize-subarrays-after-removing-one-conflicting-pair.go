package main

func maxSubarrays(s string) int {
    n := len(s)
    if n == 0 {
        return 0
    }
    count := 0
    balance := 0
    for i := 0; i < n; i++ {
        if s[i] == '0' {
            balance--
        } else {
            balance++
        }
        if balance == 0 {
            count++
        }
    }
    return count
}