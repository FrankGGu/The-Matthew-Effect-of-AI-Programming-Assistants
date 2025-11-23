func decodeString(s string) string {
    stack := []string{}
    numStack := []int{}
    currentString := ""
    currentNum := 0

    for _, char := range s {
        if char >= '0' && char <= '9' {
            currentNum = currentNum * 10 + int(char - '0')
        } else if char == '[' {
            stack = append(stack, currentString)
            numStack = append(numStack, currentNum)
            currentString = ""
            currentNum = 0
        } else if char == ']' {
            num := numStack[len(numStack)-1]
            numStack = numStack[:len(numStack)-1]
            prevString := stack[len(stack)-1]
            stack = stack[:len(stack)-1]
            currentString = prevString + strings.Repeat(currentString, num)
        } else {
            currentString += string(char)
        }
    }

    return currentString
}