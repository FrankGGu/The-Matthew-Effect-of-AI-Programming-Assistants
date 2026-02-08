func decodeString(s string) string {
    stack := []string{}
    num := 0
    currentStr := ""

    for _, char := range s {
        if char >= '0' && char <= '9' {
            num = num*10 + int(char-'0')
        } else if char == '[' {
            stack = append(stack, currentStr)
            stack = append(stack, strconv.Itoa(num))
            currentStr = ""
            num = 0
        } else if char == ']' {
            repeatCount, _ := strconv.Atoi(stack[len(stack)-1])
            stack = stack[:len(stack)-1]
            lastStr := stack[len(stack)-1]
            stack = stack[:len(stack)-1]
            for i := 0; i < repeatCount; i++ {
                lastStr += currentStr
            }
            currentStr = lastStr
        } else {
            currentStr += string(char)
        }
    }

    return currentStr
}