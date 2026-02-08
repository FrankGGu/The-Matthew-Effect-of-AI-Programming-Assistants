package main

func countPalindromicSubsequence(s string) int {
    left := make(map[byte]int)
    right := make(map[byte]int)
    for i := 0; i < len(s); i++ {
        right[s[i]]++
    }
    res := 0
    for i := 0; i < len(s); i++ {
        c := s[i]
        right[c]--
        if right[c] == 0 {
            delete(right, c)
        }
        for k := range left {
            if _, ok := right[k]; ok {
                res++
            }
        }
        left[c]++
    }
    return res
}