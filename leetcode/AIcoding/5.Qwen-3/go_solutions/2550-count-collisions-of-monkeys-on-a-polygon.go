package main

func monkeyMove(n int) int {
    mod := 1000000007
    result := 1
    for i := 0; i < n; i++ {
        result = (result * 2) % mod
    }
    return (result - 1 + mod) % mod
}