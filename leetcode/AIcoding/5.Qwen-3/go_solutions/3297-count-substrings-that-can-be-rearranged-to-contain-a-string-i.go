package main

func numberOfSubstrings(s string, t string) int {
    count := make(map[byte]int)
    for i := 0; i < len(t); i++ {
        count[t[i]]++
    }
    required := len(count)
    formed := 0
    left := 0
    result := 0
    for right := 0; right < len(s); right++ {
        if _, ok := count[s[right]]; ok {
            count[s[right]]--
            if count[s[right]] == 0 {
                formed++
            }
        }
        for formed == required {
            result += len(s) - right
            if _, ok := count[s[left]]; ok {
                count[s[left]]++
                if count[s[left]] == 1 {
                    formed--
                }
            }
            left++
        }
    }
    return result
}