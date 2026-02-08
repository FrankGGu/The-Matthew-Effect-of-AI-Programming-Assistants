package main

func findLongestSubsequence(strings []string) int {
    sort.Slice(strings, func(i, j int) bool {
        return len(strings[i]) > len(strings[j])
    })

    for i := 0; i < len(strings); i++ {
        unique := true
        for j := 0; j < len(strings); j++ {
            if i != j && isSubsequence(strings[i], strings[j]) {
                unique = false
                break
            }
        }
        if unique {
            return len(strings[i])
        }
    }
    return -1
}

func isSubsequence(s, t string) bool {
    i := 0
    for i < len(s) && len(t) > 0 {
        if s[i] == t[0] {
            i++
        }
        t = t[1:]
    }
    return i == len(s)
}