package main

func isHarshad(x int) bool {
    if x == 0 {
        return false
    }
    original := x
    sum := 0
    for x > 0 {
        sum += x % 10
        x /= 10
    }
    return original%sum == 0
}