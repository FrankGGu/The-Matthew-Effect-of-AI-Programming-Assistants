package main

func countNumbersWithUniqueDigits(n int) int {
    if n == 0 {
        return 1
    }
    if n > 10 {
        n = 10
    }
    res := 10
    for i := 2; i <= n; i++ {
        temp := 9
        for j := 1; j < i; j++ {
            temp *= (10 - j + 1)
        }
        res += temp
    }
    return res
}