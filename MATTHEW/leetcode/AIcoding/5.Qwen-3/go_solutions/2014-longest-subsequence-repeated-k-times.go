package main

func longestRepeatingSubsequence(s string, k int) string {
    var result string
    for length := len(s); length > 0; length-- {
        if findLongest(s, k, length) != "" {
            return findLongest(s, k, length)
        }
    }
    return ""
}

func findLongest(s string, k, length int) string {
    var res string
    n := len(s)
    for i := 0; i < (1 << length); i++ {
        var seq []byte
        for j := 0; j < length; j++ {
            if i&(1<<j) != 0 {
                seq = append(seq, s[j])
            }
        }
        if isRepeated(s, string(seq), k) {
            if len(seq) > len(res) || (len(seq) == len(res) && string(seq) < res) {
                res = string(seq)
            }
        }
    }
    return res
}

func isRepeated(s, sub string, k int) bool {
    count := 0
    i := 0
    for i < len(s) {
        j := 0
        for i < len(s) && j < len(sub) && s[i] == sub[j] {
            i++
            j++
        }
        if j == len(sub) {
            count++
            if count == k {
                return true
            }
        } else {
            i++
        }
    }
    return false
}