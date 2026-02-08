package main

func minimizeResult(expression string) string {
    i := 0
    for i < len(expression) && expression[i] != '+' {
        i++
    }
    left := expression[:i]
    right := expression[i+1:]

    minVal := math.MaxInt
    result := ""

    for l := 0; l < len(left); l++ {
        for r := 0; r < len(right); r++ {
            a := 1
            if l > 0 {
                a = 1
                for j := 0; j < l; j++ {
                    a *= int(expression[j] - '0')
                }
            }
            b := 1
            if r+1 < len(right) {
                for j := r + 1; j < len(right); j++ {
                    b *= int(right[j] - '0')
                }
            }
            sum := 0
            for j := l; j <= i; j++ {
                sum += int(expression[j] - '0')
            }
            total := a * (sum) * b
            if total < minVal {
                minVal = total
                result = "(" + left[:l] + "+" + right[r+1:] + ")"
            }
        }
    }

    return result
}