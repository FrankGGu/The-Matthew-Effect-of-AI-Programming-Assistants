package main

func findTheWinner(n int, k int) int {
    var f func(int) int
    f = func(x int) int {
        if x == 1 {
            return 0
        }
        return (f(x-1) + k) % x
    }
    return f(n) + 1
}