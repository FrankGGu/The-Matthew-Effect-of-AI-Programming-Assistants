package main

func solveEquation(equation string) string {
    left, right := 0, 0
    i := 0
    n := len(equation)
    for i < n && equation[i] != '=' {
        i++
    }
    leftStr := equation[:i]
    rightStr := equation[i+1:]

    parseEquation(leftStr, true, &left, &right)
    parseEquation(rightStr, false, &left, &right)

    if left == 0 {
        if right == 0 {
            return "Infinite solutions"
        } else {
            return "No solution"
        }
    }

    if right%left != 0 {
        return "No solution"
    }

    return "x=" + strconv.Itoa(right/left)
}

func parseEquation(s string, isLeft bool, x *int, c *int) {
    n := len(s)
    i := 0
    for i < n {
        sign := 1
        if s[i] == '+' {
            i++
        } else if s[i] == '-' {
            sign = -1
            i++
        }

        if i < n && s[i] == 'x' {
            *x += sign * 1
            i++
            continue
        }

        num := 0
        for i < n && s[i] >= '0' && s[i] <= '9' {
            num = num*10 + int(s[i]-'0')
            i++
        }

        if i < n && s[i] == 'x' {
            *x += sign * num
            i++
        } else {
            *c += sign * num
        }
    }
}