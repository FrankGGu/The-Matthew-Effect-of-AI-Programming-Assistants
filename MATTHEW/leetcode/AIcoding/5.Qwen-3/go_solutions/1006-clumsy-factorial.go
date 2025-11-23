package main

func clumsy(n int) int {
    if n == 1 {
        return 1
    }
    if n == 2 {
        return 2
    }
    if n == 3 {
        return 6
    }
    res := n * (n - 1) / (n - 2)
    for i := n - 3; i >= 1; i -= 4 {
        if i >= 4 {
            res -= i * (i - 1) / (i - 2)
        } else if i == 3 {
            res -= 6
        } else if i == 2 {
            res -= 2
        } else if i == 1 {
            res -= 1
        }
    }
    return res
}