package main

func checkInclusion(s1 string, s2 string) bool {
    if len(s1) > len(s2) {
        return false
    }

    var count [26]int
    for i := 0; i < len(s1); i++ {
        count[s1[i]-'a']++
    }

    for i := 0; i < len(s2); i++ {
        count[s2[i]-'a']--
        if i >= len(s1) {
            count[s2[i-len(s1)]-'a']++
        }
        if allZero(count) {
            return true
        }
    }

    return false
}

func allZero(count [26]int) bool {
    for _, v := range count {
        if v != 0 {
            return false
        }
    }
    return true
}