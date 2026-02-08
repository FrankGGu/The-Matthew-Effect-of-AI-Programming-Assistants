package main

func findTheWinner(n int, k int) int {
    var winner func(int, int) int
    winner = func(n, k int) int {
        if n == 1 {
            return 1
        }
        return (winner(n-1, k) + k - 1) % n + 1
    }
    return winner(n, k)
}