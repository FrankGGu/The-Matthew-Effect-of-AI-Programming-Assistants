package main

func countDigitOne(n int) int {
    if n < 1 {
        return 0
    }
    count := 0
    i := 1
    for i <= n {
        divider := i * 10
        count += n / divider * i
        remainder := n % i
        if remainder >= i*2 {
            count += i
        } else if remainder >= i {
            count += remainder - i + 1
        }
        i *= 10
    }
    return count
}