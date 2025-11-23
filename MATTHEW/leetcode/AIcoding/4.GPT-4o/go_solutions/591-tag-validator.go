func isValid(code string) bool {
    n := len(code)
    if n < 7 || code[:5] != "<code>" || code[n-6:] != "</code>" {
        return false
    }

    stack := []string{}
    i := 5

    for i < n-6 {
        if code[i] == '<' {
            j := i
            for j < n && code[j] != '>' {
                j++
            }
            if j == n {
                return false
            }
            tag := code[i:j+1]
            if tag[1] == '/' {
                if len(stack) == 0 || stack[len(stack)-1] != tag[2:len(tag)-1] {
                    return false
                }
                stack = stack[:len(stack)-1]
            } else {
                if len(stack) >= 10 || !isValidTag(tag[1:len(tag)-1]) {
                    return false
                }
                stack = append(stack, tag[1:len(tag)-1])
            }
            i = j + 1
        } else {
            i++
        }
    }

    return len(stack) == 0
}

func isValidTag(tag string) bool {
    if len(tag) == 0 || len(tag) > 9 {
        return false
    }
    for _, r := range tag {
        if !isAlphaNumeric(r) {
            return false
        }
    }
    return true
}

func isAlphaNumeric(r rune) bool {
    return ('a' <= r && r <= 'z') || ('A' <= r && r <= 'Z') || ('0' <= r && r <= '9')
}