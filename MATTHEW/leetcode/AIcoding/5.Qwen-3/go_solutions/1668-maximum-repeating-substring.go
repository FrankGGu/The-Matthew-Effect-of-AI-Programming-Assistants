package main

func maxRepeating(s string, sub string) int {
    count := 0
    for i := 0; i < len(s); i++ {
        j := 0
        for i+j < len(s) && s[i+j] == sub[j] {
            j++
            if j == len(sub) {
                count++
                i += j - 1
                break
            }
        }
    }
    return count
}