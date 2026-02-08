func reverseParentheses(s string) string {
    stack := []int{}
    for i := 0; i < len(s); i++ {
        if s[i] == '(' {
            stack = append(stack, i)
        } else if s[i] == ')' {
            start := stack[len(stack)-1]
            stack = stack[:len(stack)-1]
            reverse(s, start+1, i-1)
        }
    }
    res := ""
    for i := 0; i < len(s); i++ {
        if s[i] != '(' && s[i] != ')' {
            res += string(s[i])
        }
    }
    return res
}

func reverse(s string, start, end int) string {
    sBytes := []byte(s)
    for start < end {
        sBytes[start], sBytes[end] = sBytes[end], sBytes[start]
        start++
        end--
    }
    return string(sBytes)
}