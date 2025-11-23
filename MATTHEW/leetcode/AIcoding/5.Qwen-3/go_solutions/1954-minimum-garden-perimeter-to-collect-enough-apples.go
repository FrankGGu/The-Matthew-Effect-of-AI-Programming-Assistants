package main

func minPerimeter(neededApples int) int {
    n := 0
    for total := 0; total < neededApples; n++ {
        // Calculate the number of apples collected in a square of size (n+1)x(n+1)
        // The formula is 2 * (n+1) * (n+2) * (2*n + 3) / 3
        total += 2 * (n + 1) * (n + 2) * (2*n + 3) / 3
    }
    return 8 * n
}