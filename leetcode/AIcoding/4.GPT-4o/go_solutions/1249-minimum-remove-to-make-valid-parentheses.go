func minRemoveToMakeValid(s string) string {
    leftCount := 0
    for _, ch := range s {
        if ch == '(' {
            leftCount++
        } else if ch == ')' {
            if leftCount > 0 {
                leftCount--
            }
        }
    }

    result := []rune{}
    for i, ch := range s {
        if ch == '(' {
            if leftCount > 0 {
                leftCount--
            } else {
                result = append(result, ch)
            }
        } else if ch == ')' {
            if leftCount < 0 {
                result = append(result, ch)
            }
        } else {
            result = append(result, ch)
        }
    }

    return string(result)
}