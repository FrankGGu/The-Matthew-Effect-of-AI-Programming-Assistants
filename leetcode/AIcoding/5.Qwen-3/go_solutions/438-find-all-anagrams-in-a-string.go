package main

func findAnagrams(s string, p string) []int {
    if len(s) < len(p) {
        return []int{}
    }

    var count [26]int
    for i := 0; i < len(p); i++ {
        count[p[i]-'a']++
    }

    var result []int
    left := 0

    for right := 0; right < len(s); right++ {
        count[s[right]-'a']--

        if right >= len(p)-1 {
            if allZero(count) {
                result = append(result, left)
            }
            count[s[left]-'a']++
            left++
        }
    }

    return result
}

func allZero(count [26]int) bool {
    for _, v := range count {
        if v != 0 {
            return false
        }
    }
    return true
}