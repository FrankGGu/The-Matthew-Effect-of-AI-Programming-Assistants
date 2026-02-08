package main

func fourDivisors(n int) int {
    count := 0
    for i := 2; i*i <= n; i++ {
        if n%i == 0 {
            if i*i == n {
                continue
            }
            count++
        }
    }
    return count
}