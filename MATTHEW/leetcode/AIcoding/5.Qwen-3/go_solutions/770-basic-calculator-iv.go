package main

func basicCalculatorIV(expression string, target []string) []string {
    var tokens []string
    i := 0
    for i < len(expression) {
        if expression[i] == ' ' {
            i++
            continue
        }
        if expression[i] >= 'a' && expression[i] <= 'z' {
            j := i
            for j < len(expression) && (expression[j] >= 'a' && expression[j] <= 'z') {
                j++
            }
            tokens = append(tokens, expression[i:j])
            i = j
        } else if expression[i] >= '0' && expression[i] <= '9' {
            j := i
            for j < len(expression) && expression[j] >= '0' && expression[j] <= '9' {
                j++
            }
            tokens = append(tokens, expression[i:j])
            i = j
        } else {
            tokens = append(tokens, string(expression[i]))
            i++
        }
    }

    var stack []interface{}
    var expr []interface{}

    for _, token := range tokens {
        if token == "(" {
            stack = append(stack, expr)
            expr = []interface{}{}
        } else if token == ")" {
            top := stack[len(stack)-1]
            stack = stack[:len(stack)-1]
            expr = append([]interface{}{top}, expr...)
        } else if token == "+" || token == "-" || token == "*" {
            for len(expr) > 0 {
                last := expr[len(expr)-1]
                if _, ok := last.(string); ok {
                    break
                }
            }
            expr = append(expr, token)
        } else {
            expr = append(expr, token)
        }
    }

    expr = simplify(expr)

    var result []string
    for _, term := range expr {
        if s, ok := term.(string); ok {
            result = append(result, s)
        }
    }

    return result
}

func simplify(expr []interface{}) []interface{} {
    var stack []interface{}
    for _, token := range expr {
        if token == "+" || token == "-" || token == "*" {
            stack = append(stack, token)
        } else {
            if len(stack) > 0 {
                prev := stack[len(stack)-1]
                if prev == "*" {
                    stack = stack[:len(stack)-1]
                    left := stack[len(stack)-1]
                    stack = stack[:len(stack)-1]
                    right := token
                    stack = append(stack, multiply(left, right))
                } else {
                    stack = append(stack, token)
                }
            } else {
                stack = append(stack, token)
            }
        }
    }

    return stack
}

func multiply(a, b interface{}) interface{} {
    if a == "+" || a == "-" || a == "*" {
        return []interface{}{a, b}
    }
    if b == "+" || b == "-" || b == "*" {
        return []interface{}{a, b}
    }
    if _, ok := a.(string); ok && _, ok2 := b.(string); ok2 {
        return a.(string) + b.(string)
    }
    return []interface{}{a, b}
}