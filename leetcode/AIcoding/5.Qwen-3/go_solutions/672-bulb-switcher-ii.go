package main

func bulbSwitcher(n int, m int) int {
    if m == 0 {
        return 1
    }
    if n == 0 {
        return 0
    }
    if m == 1 {
        return n
    }
    if m == 2 {
        return n / 2 + n % 2
    }
    if m == 3 {
        return n / 3 + n % 3
    }
    return 0
}