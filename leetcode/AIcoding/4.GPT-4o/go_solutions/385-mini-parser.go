type NestedInteger struct {
    // This is the interface that allows for creating nested lists.
}

func deserialize(s string) *NestedInteger {
    if s[0] != '[' {
        val, _ := strconv.Atoi(s)
        return &NestedInteger{Value: val}
    }

    stack := []*NestedInteger{}
    num := 0
    sign := 1
    inNum := false

    for i := 0; i < len(s); i++ {
        if s[i] == '-' {
            sign = -1
        } else if s[i] >= '0' && s[i] <= '9' {
            num = num*10 + int(s[i]-'0')
            inNum = true
        } else if s[i] == '[' {
            stack = append(stack, &NestedInteger{})
        } else if s[i] == ']' {
            if inNum {
                stack[len(stack)-1].Add(&NestedInteger{Value: sign * num})
                num = 0
                inNum = false
                sign = 1
            }
            if len(stack) > 1 {
                top := stack[len(stack)-1]
                stack = stack[:len(stack)-1]
                stack[len(stack)-1].Add(top)
            }
        } else if s[i] == ',' {
            if inNum {
                stack[len(stack)-1].Add(&NestedInteger{Value: sign * num})
                num = 0
                inNum = false
                sign = 1
            }
        }
    }

    return stack[0]
}