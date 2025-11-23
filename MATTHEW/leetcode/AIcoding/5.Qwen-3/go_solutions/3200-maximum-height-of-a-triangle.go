package main

func maxHeight(n int) int {
    for i := 1; i <= n; i++ {
        if i*(i+1)/2 > n {
            return i - 1
        }
    }
    return 0
}