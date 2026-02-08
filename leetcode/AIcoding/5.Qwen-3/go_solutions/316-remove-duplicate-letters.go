package main

func removeDuplicateLetters(s string) string {
    last := make([]int, 26)
    for i, c := range s {
        last[c-'a'] = i
    }

    stack := []rune{}
    seen := make([]bool, 26)

    for i, c := range s {
        if seen[c-'a'] {
            continue
        }
        for len(stack) > 0 && c < stack[len(stack)-1] && last[stack[len(stack)-1]-'a'] > i {
            popped := stack[len(stack)-1]
            stack = stack[:len(stack)-1]
            seen[popped-'a'] = false
        }
        stack = append(stack, c)
        seen[c-'a'] = true
    }

    return string(stack)
}