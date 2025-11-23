func scoreOfStudents(s string, answers []int) int {
    mod := int(1e9 + 7)

    var eval func(string) int
    eval = func(expr string) int {
        stack := []int{}
        num := 0
        op := '+'
        for i := 0; i < len(expr); i++ {
            if '0' <= expr[i] && expr[i] <= '9' {
                num = num*10 + int(expr[i]-'0')
            }
            if expr[i] == '(' {
                j := i
                count := 0
                for i < len(expr) {
                    if expr[i] == '(' {
                        count++
                    } else if expr[i] == ')' {
                        count--
                    }
                    if count == 0 {
                        break
                    }
                    i++
                }
                num = eval(expr[j+1 : i])
            }
            if (expr[i] == '+' || expr[i] == '-' || expr[i] == '*' || i == len(expr)-1) && (i == 0 || expr[i-1] >= '0' && expr[i-1] <= '9') {
                switch op {
                case '+':
                    stack = append(stack, num)
                case '-':
                    stack = append(stack, -num)
                case '*':
                    stack[len(stack)-1] *= num
                }
                num = 0
                op = expr[i]
            }
        }
        result := 0
        for _, v := range stack {
            result = (result + v) % mod
        }
        return result
    }

    correct := eval(s)
    dp := make([][]int, len(s))
    for i := range dp {
        dp[i] = make([]int, 1001)
    }
    dp[0][0] = 1

    for i := 0; i < len(s); i++ {
        for j := 0; j <= 1000; j++ {
            if dp[i][j] > 0 {
                for k := 1; k <= 1000; k++ {
                    if j+k <= 1000 {
                        dp[i+1][j+k] = (dp[i+1][j+k] + dp[i][j]) % mod
                    }
                }
            }
        }
    }

    result := 0
    for _, answer := range answers {
        if answer == correct {
            result = (result + 5) % mod
        } else if answer >= 0 && answer <= 1000 {
            result = (result + dp[len(s)][answer]) % mod
        }
    }

    return result
}