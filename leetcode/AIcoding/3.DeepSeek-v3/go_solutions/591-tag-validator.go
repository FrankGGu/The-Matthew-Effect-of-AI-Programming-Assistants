func isValid(code string) bool {
    stack := []string{}
    i := 0
    n := len(code)

    for i < n {
        if i > 0 && len(stack) == 0 {
            return false
        }

        if strings.HasPrefix(code[i:], "<![CDATA[") {
            j := i + 9
            i = strings.Index(code[j:], "]]>") + j
            if i < j {
                return false
            }
            i += 3
        } else if strings.HasPrefix(code[i:], "</") {
            j := i + 2
            i = strings.IndexByte(code[j:], '>') + j
            if i < j {
                return false
            }
            tag := code[j:i]
            if len(stack) == 0 || stack[len(stack)-1] != tag {
                return false
            }
            stack = stack[:len(stack)-1]
            i++
        } else if strings.HasPrefix(code[i:], "<") {
            j := i + 1
            i = strings.IndexByte(code[j:], '>') + j
            if i < j {
                return false
            }
            tag := code[j:i]
            if !isValidTag(tag) {
                return false
            }
            stack = append(stack, tag)
            i++
        } else {
            i++
        }
    }

    return len(stack) == 0
}

func isValidTag(tag string) bool {
    if len(tag) < 1 || len(tag) > 9 {
        return false
    }
    for _, c := range tag {
        if c < 'A' || c > 'Z' {
            return false
        }
    }
    return true
}