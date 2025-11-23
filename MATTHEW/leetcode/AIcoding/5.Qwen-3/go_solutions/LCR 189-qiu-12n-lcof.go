package main

func addDigits(n int) int {
    for n >= 10 {
        sum := 0
        for n > 0 {
            sum += n % 10
            n /= 10
        }
        n = sum
    }
    return n
}