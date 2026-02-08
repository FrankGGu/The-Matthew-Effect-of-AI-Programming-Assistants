package main

func findKthNumber(n int, k int) int {
    var count int
    var result int

    for i := 1; i <= n && count < k; i++ {
        var steps int
        for j := i; j <= n; j *= 10 {
            steps += min(n - j + 1, 10)
        }
        if count + steps < k {
            count += steps
        } else {
            result = i
            break
        }
    }

    return result
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}