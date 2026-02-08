package main

func countOfAtoms(s string) string {
    stack := []map[string]int{make(map[string]int)}
    i := 0
    for i < len(s) {
        if s[i] == '(' {
            stack = append(stack, make(map[string]int))
            i++
        } else if s[i] == ')' {
            i++
            num := 0
            for i < len(s) && s[i] >= '0' && s[i] <= '9' {
                num = num*10 + int(s[i]-'0')
                i++
            }
            if num == 0 {
                num = 1
            }
            top := stack[len(stack)-1]
            stack = stack[:len(stack)-1]
            for k, v := range top {
                stack[len(stack)-1][k] += v * num
            }
        } else {
            name := ""
            for i < len(s) && s[i] >= 'a' && s[i] <= 'z' {
                name += string(s[i])
                i++
            }
            name = string(s[i]) + name
            i++
            num := 0
            for i < len(s) && s[i] >= '0' && s[i] <= '9' {
                num = num*10 + int(s[i]-'0')
                i++
            }
            if num == 0 {
                num = 1
            }
            stack[len(stack)-1][name] += num
        }
    }
    result := ""
    for k, v := range stack[0] {
        result += k
        if v > 1 {
            result += strconv.Itoa(v)
        }
    }
    return result
}