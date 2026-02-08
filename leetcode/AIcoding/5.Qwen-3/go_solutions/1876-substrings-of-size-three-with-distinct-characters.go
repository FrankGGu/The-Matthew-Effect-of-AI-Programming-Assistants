package main

func numberOfSubstrings(s string) int {
    count := make([]int, 26)
    left := 0
    result := 0
    for right := 0; right < len(s); right++ {
        count[s[right]-'a']++
        for count[s[right]-'a'] > 1 {
            count[s[left]-'a']--
            left++
        }
        if right >= 2 {
            result += left
        }
    }
    return result
}