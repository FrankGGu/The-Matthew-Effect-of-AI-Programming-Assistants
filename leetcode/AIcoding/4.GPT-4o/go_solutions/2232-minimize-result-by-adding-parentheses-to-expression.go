func minimizeResult(expression string) string {
    parts := strings.Split(expression, "+")
    left := parts[0]
    right := parts[1]

    minResult := math.MaxInt32
    bestExpression := expression

    for i := 0; i <= len(left); i++ {
        for j := 1; j <= len(right); j++ {
            modifiedExpression := left[:i] + "(" + left[i:] + "+" + right[:j] + ")" + right[j:]
            total := eval(modifiedExpression)
            if total < minResult {
                minResult = total
                bestExpression = modifiedExpression
            }
        }
    }

    return bestExpression
}

func eval(expr string) int {
    parts := strings.Split(expr, "+")
    left := parts[0]
    right := parts[1]

    leftNum := 0
    rightNum := 0

    if len(left) > 0 {
        leftNum = strToInt(left)
    }
    if len(right) > 0 {
        rightNum = strToInt(right)
    }

    return leftNum + rightNum
}

func strToInt(s string) int {
    n, _ := strconv.Atoi(s)
    return n
}