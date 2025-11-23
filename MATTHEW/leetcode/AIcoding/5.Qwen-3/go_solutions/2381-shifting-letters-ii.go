package main

func shiftingLetters(s string, shifts []int) string {
    n := len(s)
    for i := n - 2; i >= 0; i-- {
        shifts[i] = (shifts[i] + shifts[i+1]) % 26
    }
    res := make([]byte, n)
    for i := 0; i < n; i++ {
        res[i] = (s[i] - 'a' + byte(shifts[i])) % 26 + 'a'
    }
    return string(res)
}