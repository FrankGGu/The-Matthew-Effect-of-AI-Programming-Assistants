package main

func tribonacci(n int) int {
    if n == 0 {
        return 0
    } else if n == 1 || n == 2 {
        return 1
    }
    a, b, c := 0, 1, 1
    for i := 3; i <= n; i++ {
        d := a + b + c
        a, b, c = b, c, d
    }
    return c
}