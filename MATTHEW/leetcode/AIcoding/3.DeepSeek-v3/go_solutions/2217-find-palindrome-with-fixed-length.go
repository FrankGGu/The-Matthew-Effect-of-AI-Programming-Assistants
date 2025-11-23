func kthPalindrome(queries []int, intLength int) []int64 {
    res := make([]int64, len(queries))
    half := (intLength + 1) / 2
    start := int64(math.Pow10(half - 1))
    end := int64(math.Pow10(half)) - 1

    for i, q := range queries {
        if q > int(end - start + 1) {
            res[i] = -1
            continue
        }
        halfNum := start + int64(q) - 1
        s := strconv.FormatInt(halfNum, 10)
        var sb strings.Builder
        sb.WriteString(s)
        if intLength % 2 == 0 {
            sb.WriteString(reverse(s))
        } else {
            sb.WriteString(reverse(s[:len(s)-1]))
        }
        num, _ := strconv.ParseInt(sb.String(), 10, 64)
        res[i] = num
    }
    return res
}

func reverse(s string) string {
    runes := []rune(s)
    for i, j := 0, len(runes)-1; i < j; i, j = i+1, j-1 {
        runes[i], runes[j] = runes[j], runes[i]
    }
    return string(runes)
}