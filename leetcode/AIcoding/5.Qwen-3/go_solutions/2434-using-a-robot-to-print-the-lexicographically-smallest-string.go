package main

func robotWithString(s string) string {
    stack := []rune{}
    result := []rune{}
    count := make([]int, 26)
    for _, c := range s {
        count[c-'a']++
    }
    for _, c := range s {
        for len(stack) > 0 && stack[len(stack)-1] <= c && count[stack[len(stack)-1]-'a'] > 0 {
            result = append(result, stack[len(stack)-1])
            stack = stack[:len(stack)-1]
        }
        stack = append(stack, c)
    }
    for len(stack) > 0 {
        result = append(result, stack[len(stack)-1])
        stack = stack[:len(stack)-1]
    }
    return string(result)
}