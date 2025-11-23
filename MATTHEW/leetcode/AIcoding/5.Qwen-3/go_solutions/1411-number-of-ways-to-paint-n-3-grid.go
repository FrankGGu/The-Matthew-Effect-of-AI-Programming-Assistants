package main

func numWays(n int) int {
    if n == 0 {
        return 0
    }
    if n == 1 {
        return 3
    }
    // a: number of ways to paint the grid with two colors in the same row
    // b: number of ways to paint the grid with three colors in the same row
    a, b := 3, 2
    for i := 2; i <= n; i++ {
        newA := (a * 2 + b * 2) % (1e9 + 7)
        newB := (a * 1 + b * 1) % (1e9 + 7)
        a, b = newA, newB
    }
    return a
}