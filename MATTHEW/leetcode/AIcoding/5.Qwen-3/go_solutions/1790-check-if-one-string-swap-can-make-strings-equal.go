package main

func areAlmostEqual(s string, t string) bool {
    if len(s) != len(t) {
        return false
    }
    var diff []int
    for i := 0; i < len(s); i++ {
        if s[i] != t[i] {
            diff = append(diff, i)
            if len(diff) > 2 {
                return false
            }
        }
    }
    return len(diff) == 0 || (len(diff) == 2 && s[diff[0]] == t[diff[1]] && s[diff[1]] == t[diff[0]])
}