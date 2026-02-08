func strongPasswordChecker(password string) int {
    n := len(password)
    hasLower, hasUpper, hasDigit, hasSpecial := false, false, false, false
    specialChars := "!@#$%^&*()-+"

    for _, ch := range password {
        switch {
        case ch >= 'a' && ch <= 'z':
            hasLower = true
        case ch >= 'A' && ch <= 'Z':
            hasUpper = true
        case ch >= '0' && ch <= '9':
            hasDigit = true
        case strings.ContainsRune(specialChars, ch):
            hasSpecial = true
        }
    }

    missingTypes := 0
    if !hasLower {
        missingTypes++
    }
    if !hasUpper {
        missingTypes++
    }
    if !hasDigit {
        missingTypes++
    }
    if !hasSpecial {
        missingTypes++
    }

    if n < 6 {
        return max(missingTypes, 6-n)
    } else if n <= 20 {
        return missingTypes
    } else {
        excess := n - 20
        replace := 0
        counts := make([]int, 3)

        for i := 0; i < n; {
            j := i
            for j < n && password[i] == password[j] {
                j++
            }
            length := j - i
            if length >= 3 {
                counts[length%3]++
                replace += length / 3
            }
            i = j
        }

        if replace <= excess {
            return missingTypes
        }
        replace -= excess
        missingTypes += max(0, replace)

        return missingTypes
    }
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}