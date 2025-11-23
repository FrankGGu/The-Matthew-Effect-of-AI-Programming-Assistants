func scoreOfStudents(s string, answers []int) int {
    n := len(s)
    m := (n + 1) / 2
    dp := make([][]map[int]bool, m)
    for i := range dp {
        dp[i] = make([]map[int]bool, m)
        for j := range dp[i] {
            dp[i][j] = make(map[int]bool)
        }
    }

    for i := 0; i < m; i++ {
        num := int(s[i*2] - '0')
        dp[i][i][num] = true
    }

    for l := 1; l < m; l++ {
        for i := 0; i < m-l; i++ {
            j := i + l
            for k := i; k < j; k++ {
                op := s[k*2+1]
                for a := range dp[i][k] {
                    for b := range dp[k+1][j] {
                        var res int
                        if op == '+' {
                            res = a + b
                        } else {
                            res = a * b
                        }
                        if res <= 1000 {
                            dp[i][j][res] = true
                        }
                    }
                }
            }
        }
    }

    correct := calculate(s)
    res := 0
    possible := dp[0][m-1]
    for _, ans := range answers {
        if ans == correct {
            res += 5
        } else if possible[ans] {
            res += 2
        }
    }
    return res
}

func calculate(s string) int {
    stack := []int{}
    num := 0
    var sign byte = '+'
    for i := 0; i < len(s); i++ {
        if s[i] >= '0' && s[i] <= '9' {
            num = num*10 + int(s[i]-'0')
        }
        if i == len(s)-1 || s[i] == '+' || s[i] == '*' {
            if sign == '+' {
                stack = append(stack, num)
            } else if sign == '*' {
                top := stack[len(stack)-1]
                stack = stack[:len(stack)-1]
                stack = append(stack, top*num)
            }
            sign = s[i]
            num = 0
        }
    }
    res := 0
    for _, v := range stack {
        res += v
    }
    return res
}