package main

func pivotInteger(x int) int {
    s := x * (x + 1) / 2
    for i := 1; i <= x; i++ {
        if i*(i+1)/2 == s-i*(i+1)/2 {
            return i
        }
    }
    return -1
}