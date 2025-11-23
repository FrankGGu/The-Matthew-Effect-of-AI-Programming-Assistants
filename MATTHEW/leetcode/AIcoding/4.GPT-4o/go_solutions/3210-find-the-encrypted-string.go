func decode(encodedString string) string {
    stack := []rune{}
    num := 0

    for i := len(encodedString) - 1; i >= 0; i-- {
        ch := encodedString[i]
        if ch >= '0' && ch <= '9' {
            num = int(ch-'0') + num*10
        } else if ch == ']' {
            stack = append(stack, ']')
        } else if ch == '[' {
            temp := []rune{}
            for len(stack) > 0 && stack[len(stack)-1] != ']' {
                temp = append(temp, stack[len(stack)-1])
                stack = stack[:len(stack)-1]
            }
            stack = stack[:len(stack)-1] // pop ']'
            for j := 0; j < num; j++ {
                for k := len(temp) - 1; k >= 0; k-- {
                    stack = append(stack, temp[k])
                }
            }
            num = 0
        } else {
            stack = append(stack, ch)
        }
    }

    result := []rune{}
    for i := len(stack) - 1; i >= 0; i-- {
        result = append(result, stack[i])
    }
    return string(result)
}