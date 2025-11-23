package main

func findAnagrams(s string, p string) []int {
    if len(s) < len(p) {
        return []int{}
    }
    var result []int
    count := make([]int, 26)
    for i := 0; i < len(p); i++ {
        count[p[i]-'a']++
    }
    left := 0
    for right := 0; right < len(s); right++ {
        count[s[right]-'a']--
        if right >= len(p) {
            count[s[left]-'a']++
            left++
        }
        if isZero(count) {
            result = append(result, left)
        }
    }
    return result
}

func isZero(count []int) bool {
    for _, v := range count {
        if v != 0 {
            return false
        }
    }
    return true
}