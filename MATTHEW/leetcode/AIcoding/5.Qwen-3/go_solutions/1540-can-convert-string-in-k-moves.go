package main

func canConvertString(s string, t string) bool {
    if len(s) != len(t) {
        return false
    }
    count := make(map[int]int)
    for i := 0; i < len(s); i++ {
        if s[i] == t[i] {
            continue
        }
        diff := int(t[i] - s[i])
        if diff < 0 {
            diff += 26
        }
        if count[diff] >= 1 && diff != 0 {
            count[diff]++
        } else {
            count[diff] = 1
        }
    }
    for k, v := range count {
        if k == 0 {
            continue
        }
        if v > 1 {
            return false
        }
    }
    return true
}