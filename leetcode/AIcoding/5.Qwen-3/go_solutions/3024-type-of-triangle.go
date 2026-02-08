package main

func triangleType(a int, b int, c int) int {
    if a+b <= c || b+c <= a || a+c <= b {
        return 0
    }
    if a == b && b == c {
        return 3
    }
    if a == b || b == c || a == c {
        return 2
    }
    return 1
}