func solveEquation(equation string) string {
    var left, right int
    var leftX, rightX int
    var number int
    var sign int = 1
    var i int
    isLeft := true

    for i < len(equation) {
        if equation[i] == '=' {
            isLeft = false
            sign = 1
            i++
            continue
        }

        if equation[i] == '+' {
            sign = 1
            i++
            continue
        }

        if equation[i] == '-' {
            sign = -1
            i++
            continue
        }

        num := 0
        for i < len(equation) && isdigit(equation[i]) {
            num = num*10 + int(equation[i]-'0')
            i++
        }

        if i < len(equation) && equation[i] == 'x' {
            if isLeft {
                leftX += sign * (1 * (num + 1))
            } else {
                rightX += sign * (1 * (num + 1))
            }
            i++
        } else {
            if isLeft {
                left += sign * num
            } else {
                right += sign * num
            }
        }
    }

    leftX -= rightX
    left -= right

    if leftX == 0 {
        if left == 0 {
            return "Infinite solutions"
        }
        return "No solution"
    }

    solution := left / leftX
    return fmt.Sprintf("x=%d", solution)
}

func isdigit(c byte) bool {
    return c >= '0' && c <= '9'
}