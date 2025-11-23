func removeDuplicateLetters(s string) string {
    lastOcc := [26]int{}
    for i := 0; i < len(s); i++ {
        lastOcc[s[i]-'a'] = i
    }

    stack := []byte{}
    inStack := [26]bool{}

    for i := 0; i < len(s); i++ {
        char := s[i]
        if inStack[char-'a'] {
            continue
        }

        for len(stack) > 0 && char < stack[len(stack)-1] && lastOcc[stack[len(stack)-1]-'a'] > i {
            topChar := stack[len(stack)-1]
            stack = stack[:len(stack)-1]
            inStack[topChar-'a'] = false
        }

        stack = append(stack, char)
        inStack[char-'a'] = true
    }

    return string(stack)
}