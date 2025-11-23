package main

func memLeak(a int, b int) []int {
    i := 1
    for a >= i || b >= i {
        if a >= b {
            a -= i
        } else {
            b -= i
        }
        i++
    }
    return []int{i - 1, a, b}
}