package main

func canConvertString(s1 string, s2 string) bool {
    if len(s1) != len(s2) {
        return false
    }
    count := [26]int{}
    for i := 0; i < len(s1); i++ {
        a, b := s1[i], s2[i]
        if a == b {
            continue
        }
        diff := int(a - b)
        if diff < 0 {
            diff += 26
        }
        if count[diff] >= 1 {
            return false
        }
        count[diff]++
    }
    return true
}