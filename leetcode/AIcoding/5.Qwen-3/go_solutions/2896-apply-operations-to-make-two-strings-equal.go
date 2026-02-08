package main

func canBeEqual(target string, s string) bool {
    if len(target) != len(s) {
        return false
    }
    count := make([]int, 26)
    for i := 0; i < len(target); i++ {
        count[target[i]-'a']++
        count[s[i]-'a']--
    }
    for _, v := range count {
        if v != 0 {
            return false
        }
    }
    return true
}