func largestPalindromic(num string) string {
    count := make([]int, 10)
    for _, ch := range num {
        count[ch-'0']++
    }

    half := ""
    for i := 9; i >= 0; i-- {
        for count[i] > 1 {
            half += strconv.Itoa(i)
            count[i] -= 2
        }
    }

    middle := ""
    for i := 9; i >= 0; i-- {
        if count[i] > 0 {
            middle = strconv.Itoa(i)
            break
        }
    }

    if half == "" && middle == "" {
        return "0"
    }

    if middle != "" && half == "" {
        return middle
    }

    palindromic := half
    if middle != "" {
        palindromic += middle
    }
    for i := len(half) - 1; i >= 0; i-- {
        palindromic += string(half[i])
    }

    if palindromic[0] == '0' {
        return "0"
    }

    return palindromic
}