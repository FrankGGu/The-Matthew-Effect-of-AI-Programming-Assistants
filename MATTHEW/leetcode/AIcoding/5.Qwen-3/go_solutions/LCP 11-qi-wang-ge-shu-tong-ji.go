package main

func expectedNumbers(s string) []int {
    n := len(s)
    res := make([]int, 0)
    for i := 0; i < n; i++ {
        if s[i] == 'a' || s[i] == 'e' || s[i] == 'i' || s[i] == 'o' || s[i] == 'u' {
            count := 1
            j := i + 1
            for j < n && s[j] == s[i] {
                count++
                j++
            }
            res = append(res, count)
            i = j - 1
        }
    }
    return res
}