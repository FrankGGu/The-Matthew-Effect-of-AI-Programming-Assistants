package main

func evaluate(s string, knowledge [][]string) string {
    stack := []rune{}
    mapK := make(map[string]string)
    for _, pair := range knowledge {
        mapK[pair[0]] = pair[1]
    }
    i := 0
    for i < len(s) {
        if s[i] == '(' {
            i++
            key := ""
            for i < len(s) && s[i] != ')' {
                key += string(s[i])
                i++
            }
            i++
            stack = append(stack, []rune(mapK[key])...)
        } else {
            stack = append(stack, rune(s[i]))
            i++
        }
    }
    return string(stack)
}