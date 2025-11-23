package main

func removeDuplicates(s string, k int) string {
    stack := [][]rune{}
    for _, char := range s {
        if len(stack) > 0 && stack[len(stack)-1][0] == char {
            stack[len(stack)-1][1]++
            if stack[len(stack)-1][1] == int32(k) {
                stack = stack[:len(stack)-1]
            }
        } else {
            stack = append(stack, []rune{char, 1})
        }
    }
    result := []rune{}
    for _, pair := range stack {
        for i := 0; i < int(pair[1]); i++ {
            result = append(result, pair[0])
        }
    }
    return string(result)
}