func removeDuplicateLetters(s string) string {
    lastIndex := [26]int{}
    for i, c := range s {
        lastIndex[c-'a'] = i
    }

    stack := []byte{}
    inStack := [26]bool{}

    for i, c := range s {
        if inStack[c-'a'] {
            continue
        }
        for len(stack) > 0 && stack[len(stack)-1] > byte(c) && lastIndex[stack[len(stack)-1]-'a'] > i {
            inStack[stack[len(stack)-1]-'a'] = false
            stack = stack[:len(stack)-1]
        }
        stack = append(stack, byte(c))
        inStack[c-'a'] = true
    }

    return string(stack)
}