package main

func strongPasswordChecker(s string) int {
    missingType := 0
    if !containsLower(s) {
        missingType++
    }
    if !containsUpper(s) {
        missingType++
    }
    if !containsDigit(s) {
        missingType++
    }

    n := len(s)
    if n < 6 {
        return max(6-n, missingType)
    }

    if n <= 20 {
        var replace [3]int
        for i := 0; i < n; {
            j := i
            for j < n && s[j] == s[i] {
                j++
            }
            length := j - i
            if length >= 3 {
                replace[length%3]++
            }
            i = j
        }

        res := 0
        for i := 0; i < 3; i++ {
            if i < missingType {
                res += replace[i]
                missingType--
            } else {
                break
            }
        }

        if missingType > 0 {
            res += missingType
        }

        return res
    }

    var replace [3]int
    var extra []int

    for i := 0; i < n; {
        j := i
        for j < n && s[j] == s[i] {
            j++
        }
        length := j - i
        if length >= 3 {
            replace[length%3]++
            if length >= 20 {
                extra = append(extra, length)
            }
        }
        i = j
    }

    res := 0
    for i := 0; i < 3; i++ {
        if i < missingType {
            res += replace[i]
            missingType--
        } else {
            break
        }
    }

    if missingType > 0 {
        res += missingType
    }

    for i := 0; i < len(extra); i++ {
        if i < 2 {
            res += 1
            extra[i] -= 2
        } else {
            res += 1
            extra[i] -= 3
        }
    }

    for _, l := range extra {
        if l > 20 {
            res += (l - 20 + 2) / 3
        }
    }

    return res
}

func containsLower(s string) bool {
    for _, c := range s {
        if c >= 'a' && c <= 'z' {
            return true
        }
    }
    return false
}

func containsUpper(s string) bool {
    for _, c := range s {
        if c >= 'A' && c <= 'Z' {
            return true
        }
    }
    return false
}

func containsDigit(s string) bool {
    for _, c := range s {
        if c >= '0' && c <= '9' {
            return true
        }
    }
    return false
}