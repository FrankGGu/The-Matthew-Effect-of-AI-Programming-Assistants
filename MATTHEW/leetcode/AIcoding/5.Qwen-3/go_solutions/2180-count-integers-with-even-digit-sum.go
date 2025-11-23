package main

func countEven(n int) int {
    count := 0
    for i := 1; i <= n; i++ {
        sum := 0
        num := i
        for num > 0 {
            sum += num % 10
            num /= 10
        }
        if sum%2 == 0 {
            count++
        }
    }
    return count
}