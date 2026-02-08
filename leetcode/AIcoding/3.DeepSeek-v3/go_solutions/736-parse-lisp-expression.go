func evaluate(expression string) int {
    scopes := make([]map[string]int, 0)
    scopes = append(scopes, make(map[string]int))
    return eval(expression, &scopes)
}

func eval(expr string, scopes *[]map[string]int) int {
    if expr[0] != '(' {
        if expr[0] >= '0' && expr[0] <= '9' || expr[0] == '-' {
            num, _ := strconv.Atoi(expr)
            return num
        }
        for i := len(*scopes) - 1; i >= 0; i-- {
            if val, ok := (*scopes)[i][expr]; ok {
                return val
            }
        }
        return 0
    }
    tokens := parse(expr[1 : len(expr)-1])
    if tokens[0] == "add" {
        return eval(tokens[1], scopes) + eval(tokens[2], scopes)
    } else if tokens[0] == "mult" {
        return eval(tokens[1], scopes) * eval(tokens[2], scopes)
    } else {
        (*scopes) = append((*scopes), make(map[string]int))
        for i := 1; i < len(tokens)-1; i += 2 {
            (*scopes)[len(*scopes)-1][tokens[i]] = eval(tokens[i+1], scopes)
        }
        res := eval(tokens[len(tokens)-1], scopes)
        (*scopes) = (*scopes)[:len(*scopes)-1]
        return res
    }
}

func parse(expr string) []string {
    res := make([]string, 0)
    balance := 0
    start := 0
    for i := 0; i < len(expr); i++ {
        if expr[i] == '(' {
            balance++
        } else if expr[i] == ')' {
            balance--
        } else if expr[i] == ' ' && balance == 0 {
            res = append(res, expr[start:i])
            start = i + 1
        }
    }
    res = append(res, expr[start:])
    return res
}