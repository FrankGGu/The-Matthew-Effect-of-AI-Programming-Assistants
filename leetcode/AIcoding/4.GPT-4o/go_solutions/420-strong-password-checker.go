func strongPasswordChecker(password string) int {
    hasLower := false
    hasUpper := false
    hasDigit := false
    n := len(password)

    for _, c := range password {
        if c >= 'a' && c <= 'z' {
            hasLower = true
        } else if c >= 'A' && c <= 'Z' {
            hasUpper = true
        } else if c >= '0' && c <= '9' {
            hasDigit = true
        }
    }

    typesNeeded := 0
    if !hasLower {
        typesNeeded++
    }
    if !hasUpper {
        typesNeeded++
    }
    if !hasDigit {
        typesNeeded++
    }

    if n < 6 {
        return max(typesNeeded, 6-n)
    } else if n <= 20 {
        return typesNeeded
    }

    excess := n - 20
    repeatCounts := make(map[int]int)
    i := 2
    for i < n {
        count := 2
        for i < n && password[i] == password[i-1] {
            count++
            i++
        }
        if count >= 3 {
            repeatCounts[count]++
        }
    }

    changes := 0
    for count, freq := range repeatCounts {
        for freq > 0 && excess > 0 {
            if count % 3 == 0 {
                count -= 1
            } else if count % 3 == 1 {
                count -= 2
            } else {
                count -= 3
            }
            changes++
            excess--
            if count > 0 {
                repeatCounts[count]++
            }
            freq--
        }
    }

    changes += excess

    return changes + typesNeeded
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}