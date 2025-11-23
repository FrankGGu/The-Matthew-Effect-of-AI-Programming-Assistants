func strongPasswordChecker(password string) int {
    n := len(password)
    hasLower, hasUpper, hasDigit := 0, 0, 0
    for _, ch := range password {
        if unicode.IsLower(ch) {
            hasLower = 1
        } else if unicode.IsUpper(ch) {
            hasUpper = 1
        } else if unicode.IsDigit(ch) {
            hasDigit = 1
        }
    }
    categories := hasLower + hasUpper + hasDigit

    switch {
    case n < 6:
        return max(6-n, 3-categories)
    case n <= 20:
        replace := 0
        cnt := 1
        for i := 1; i < n; i++ {
            if password[i] == password[i-1] {
                cnt++
            } else {
                replace += cnt / 3
                cnt = 1
            }
        }
        replace += cnt / 3
        return max(replace, 3-categories)
    default:
        replace := 0
        remove := n - 20
        rm2 := 0
        cnt := 1
        for i := 1; i < n; i++ {
            if password[i] == password[i-1] {
                cnt++
            } else {
                if remove > 0 && cnt >= 3 {
                    if cnt%3 == 0 {
                        remove--
                        replace--
                    } else if cnt%3 == 1 {
                        rm2++
                    }
                }
                replace += cnt / 3
                cnt = 1
            }
        }
        if remove > 0 && cnt >= 3 {
            if cnt%3 == 0 {
                remove--
                replace--
            } else if cnt%3 == 1 {
                rm2++
            }
        }
        replace += cnt / 3

        use2 := min(min(replace, rm2), remove/2)
        replace -= use2
        remove -= use2 * 2

        use3 := min(replace, remove/3)
        replace -= use3
        return (n - 20) + max(replace, 3-categories)
    }
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}