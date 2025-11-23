package main

func minRemoveToMakeValid(s string) string {
    stack := []int{}
    toRemove := make(map[int]bool)

    for i, c := range s {
        if c == '(' {
            stack = append(stack, i)
        } else if c == ')' {
            if len(stack) > 0 {
                stack = stack[:len(stack)-1]
            } else {
                toRemove[i] = true
            }
        }
    }

    for _, i := range stack {
        toRemove[i] = true
    }

    result := []rune{}
    for i, c := range s {
        if !toRemove[i] {
            result = append(result, c)
        }
    }

    return string(result)
}