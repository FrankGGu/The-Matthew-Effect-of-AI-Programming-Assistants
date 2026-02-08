func removeOuterParentheses(S string) string {
    count := 0
    result := []byte{}

    for i := 0; i < len(S); i++ {
        if S[i] == '(' {
            if count > 0 {
                result = append(result, S[i])
            }
            count++
        } else {
            count--
            if count > 0 {
                result = append(result, S[i])
            }
        }
    }

    return string(result)
}