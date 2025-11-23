func parseBoolExpr(expression string) bool {
    stack := []bool{}
    operators := map[rune]func(bool, bool) bool{
        '&': func(a, b bool) bool { return a && b },
        '|': func(a, b bool) bool { return a || b },
    }

    var evaluate func(string) bool
    evaluate = func(expr string) bool {
        if expr == "t" {
            return true
        }
        if expr == "f" {
            return false
        }

        var op rune
        i := 0
        for i < len(expr) {
            if expr[i] == '!' {
                i++
                stack = append(stack, !evaluate(string(expr[i])))
                i++
            } else if expr[i] == '(' {
                op = rune(expr[i-1])
                i++
                subExpr := ""
                count := 1
                for count > 0 {
                    if expr[i] == '(' {
                        count++
                    } else if expr[i] == ')' {
                        count--
                    }
                    if count > 0 {
                        subExpr += string(expr[i])
                    }
                    i++
                }
                stack = append(stack, evaluate(subExpr))
            } else if expr[i] == 't' || expr[i] == 'f' {
                stack = append(stack, expr[i] == 't')
                i++
            }
            if i < len(expr) && (expr[i] == ',' || expr[i] == ')') {
                if len(stack) > 1 {
                    last := stack[len(stack)-1]
                    stack = stack[:len(stack)-1]
                    secondLast := stack[len(stack)-1]
                    stack = stack[:len(stack)-1]
                    stack = append(stack, operators[op](secondLast, last))
                }
                i++
            }
        }
        return stack[0]
    }

    return evaluate(expression)
}