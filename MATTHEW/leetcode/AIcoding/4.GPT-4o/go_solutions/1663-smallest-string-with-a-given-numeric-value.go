func getSmallestString(n int, value int) string {
    result := make([]byte, n)
    for i := 0; i < n; i++ {
        if value >= 26 {
            result[i] = 'a' + 25
            value -= 26
        } else {
            result[i] = 'a' + byte(value-1)
            value = 0
        }
    }

    for i := 0; i < n; i++ {
        if value > 0 && result[i] > 'a' {
            diff := min(value, int(result[i]-'a'))
            result[i] -= byte(diff)
            value -= diff
        }
        if value == 0 {
            break
        }
    }

    return string(result)
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}