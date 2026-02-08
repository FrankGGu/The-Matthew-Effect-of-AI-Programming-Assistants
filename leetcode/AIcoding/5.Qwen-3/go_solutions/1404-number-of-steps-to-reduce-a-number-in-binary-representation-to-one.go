package main

func numSteps(s string) int {
    steps := 0
    n := len(s)
    for n > 1 {
        if s[n-1] == '1' {
            steps++
            carry := 1
            for n > 0 && carry > 0 {
                n--
                if s[n] == '1' {
                    s = s[:n] + "0" + s[n+1:]
                    carry = 1
                } else {
                    s = s[:n] + "1" + s[n+1:]
                    carry = 0
                }
            }
            if n == 0 {
                steps++
            }
        } else {
            steps++
        }
        n--
    }
    return steps
}