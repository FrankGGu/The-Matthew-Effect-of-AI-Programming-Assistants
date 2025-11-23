package main

func alternateDigitSum(n int) int {
    sign := 1
    result := 0
    for n > 0 {
        result += sign * (n % 10)
        sign *= -1
        n /= 10
    }
    return result
}