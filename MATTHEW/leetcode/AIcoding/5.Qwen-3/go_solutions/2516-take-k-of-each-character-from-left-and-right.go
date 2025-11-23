package main

func takeCharacters(s string) int {
    count := make([]int, 26)
    for _, c := range s {
        count[c-'a']++
    }
    n := len(s)
    left := 0
    right := n - 1
    res := 0
    for left <= right {
        if count[s[left]-'a'] > 0 && count[s[right]-'a'] > 0 {
            count[s[left]-'a']--
            count[s[right]-'a']--
            left++
            right--
            res += 2
        } else if count[s[left]-'a'] > 0 {
            count[s[left]-'a']--
            left++
            res++
        } else if count[s[right]-'a'] > 0 {
            count[s[right]-'a']--
            right--
            res++
        } else {
            break
        }
    }
    return res
}