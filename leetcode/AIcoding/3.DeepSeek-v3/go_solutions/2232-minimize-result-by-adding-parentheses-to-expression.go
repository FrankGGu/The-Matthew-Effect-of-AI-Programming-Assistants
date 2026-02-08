func minimizeResult(expression string) string {
    plusPos := strings.Index(expression, "+")
    left := expression[:plusPos]
    right := expression[plusPos+1:]
    minVal := math.MaxInt32
    result := ""

    for i := 0; i < len(left); i++ {
        a := 1
        if i > 0 {
            a, _ = strconv.Atoi(left[:i])
        }
        b, _ := strconv.Atoi(left[i:])

        for j := 1; j <= len(right); j++ {
            c, _ := strconv.Atoi(right[:j])
            d := 1
            if j < len(right) {
                d, _ = strconv.Atoi(right[j:])
            }

            current := a * (b + c) * d
            if current < minVal {
                minVal = current
                result = fmt.Sprintf("%s(%s+%s)%s", left[:i], left[i:], right[:j], right[j:])
            }
        }
    }

    return result
}