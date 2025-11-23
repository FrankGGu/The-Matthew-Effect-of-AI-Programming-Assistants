package main

func tagValidator(code string) string {
    stack := []string{}
    i := 0
    n := len(code)
    for i < n {
        if code[i] == '<' {
            if i+1 < n && code[i+1] == '/' {
                // closing tag
                i += 2
                j := i
                for j < n && code[j] != '>' {
                    j++
                }
                if j >= n {
                    return "Not Valid"
                }
                tagName := code[i:j]
                if len(tagName) == 0 || len(tagName) > 9 {
                    return "Not Valid"
                }
                for _, c := range tagName {
                    if !('A' <= c && c <= 'Z') {
                        return "Not Valid"
                    }
                }
                if len(stack) == 0 || stack[len(stack)-1] != tagName {
                    return "Not Valid"
                }
                stack = stack[:len(stack)-1]
                i = j + 1
            } else {
                // opening tag
                i++
                j := i
                for j < n && code[j] != '>' {
                    j++
                }
                if j >= n {
                    return "Not Valid"
                }
                tagName := code[i:j]
                if len(tagName) == 0 || len(tagName) > 9 {
                    return "Not Valid"
                }
                for _, c := range tagName {
                    if !('A' <= c && c <= 'Z') {
                        return "Not Valid"
                    }
                }
                stack = append(stack, tagName)
                i = j + 1
            }
        } else {
            if len(stack) == 0 {
                return "Not Valid"
            }
            i++
        }
    }
    if len(stack) > 0 {
        return "Not Valid"
    }
    return "Valid"
}