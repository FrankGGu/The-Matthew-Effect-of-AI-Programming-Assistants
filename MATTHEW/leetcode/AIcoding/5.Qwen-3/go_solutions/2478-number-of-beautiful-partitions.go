package main

func numDifferentIntegers(s string) int {
    set := make(map[string]bool)
    n := len(s)
    i := 0
    for i < n {
        if s[i] == '0' {
            j := i
            for j < n && s[j] == '0' {
                j++
            }
            if j == i+1 {
                set["0"] = true
            } else {
                set[s[i:j]] = true
            }
            i = j
        } else if s[i] >= '0' && s[i] <= '9' {
            j := i
            for j < n && s[j] >= '0' && s[j] <= '9' {
                j++
            }
            set[s[i:j]] = true
            i = j
        } else {
            i++
        }
    }
    return len(set)
}