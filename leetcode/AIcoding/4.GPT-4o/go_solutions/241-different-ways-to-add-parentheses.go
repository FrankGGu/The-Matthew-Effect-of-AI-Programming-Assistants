func diffWaysToCompute(expression string) []int {
    if expression == "" {
        return []int{}
    }

    res := []int{}

    for i := 0; i < len(expression); i++ {
        if expression[i] == '+' || expression[i] == '-' || expression[i] == '*' {
            left := diffWaysToCompute(expression[:i])
            right := diffWaysToCompute(expression[i+1:])

            for _, l := range left {
                for _, r := range right {
                    if expression[i] == '+' {
                        res = append(res, l+r)
                    } else if expression[i] == '-' {
                        res = append(res, l-r)
                    } else if expression[i] == '*' {
                        res = append(res, l*r)
                    }
                }
            }
        }
    }

    if len(res) == 0 {
        num := 0
        for i := 0; i < len(expression); i++ {
            num = num*10 + int(expression[i]-'0')
        }
        res = append(res, num)
    }

    return res
}