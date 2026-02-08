package main

func countIntegers(n int) int {
    return count(n)
}

func count(n int) int {
    if n < 10 {
        return 0
    }
    s := []byte(strconv.Itoa(n))
    m := len(s)
    res := 0
    for i := 1; i <= m-1; i++ {
        res += 9 * pow(10, i-1)
    }
    for i := 0; i < m; i++ {
        digit := int(s[i] - '0')
        if i == 0 {
            res += (digit - 1) * pow(10, m-1-i)
        } else {
            res += (digit) * pow(10, m-1-i)
        }
        if i < m-1 {
            res -= pow(10, m-1-i)
        }
    }
    return res
}

func pow(a, b int) int {
    res := 1
    for b > 0 {
        res *= a
        b--
    }
    return res
}