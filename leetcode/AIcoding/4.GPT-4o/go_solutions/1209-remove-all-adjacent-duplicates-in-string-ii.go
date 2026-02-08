func removeDuplicates(s string, k int) string {
    stack := [][]interface{}{}
    for _, ch := range s {
        if len(stack) > 0 && stack[len(stack)-1][0] == ch {
            stack[len(stack)-1][1] = stack[len(stack)-1][1].(int) + 1
            if stack[len(stack)-1][1].(int) == k {
                stack = stack[:len(stack)-1]
            }
        } else {
            stack = append(stack, []interface{}{ch, 1})
        }
    }
    result := ""
    for _, item := range stack {
        ch := item[0].(rune)
        count := item[1].(int)
        for i := 0; i < count; i++ {
            result += string(ch)
        }
    }
    return result
}