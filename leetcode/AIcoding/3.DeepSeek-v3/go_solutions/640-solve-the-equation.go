func solveEquation(equation string) string {
    leftX, leftNum := 0, 0
    rightX, rightNum := 0, 0
    flag := 1
    left := true
    i := 0
    n := len(equation)

    for i < n {
        if equation[i] == '=' {
            left = false
            flag = 1
            i++
            continue
        }

        sign := 1
        if equation[i] == '+' {
            sign = 1
            i++
        } else if equation[i] == '-' {
            sign = -1
            i++
        }

        if left {
            sign *= flag
        } else {
            sign *= -flag
        }

        num := 0
        isNum := false
        for i < n && equation[i] >= '0' && equation[i] <= '9' {
            num = num*10 + int(equation[i]-'0')
            i++
            isNum = true
        }

        if i < n && equation[i] == 'x' {
            if !isNum {
                num = 1
            }
            if left {
                leftX += sign * num
            } else {
                rightX += sign * num
            }
            i++
        } else {
            if left {
                leftNum += sign * num
            } else {
                rightNum += sign * num
            }
        }
    }

    totalX := leftX - rightX
    totalNum := rightNum - leftNum

    if totalX == 0 {
        if totalNum == 0 {
            return "Infinite solutions"
        } else {
            return "No solution"
        }
    } else {
        return fmt.Sprintf("x=%d", totalNum/totalX)
    }
}