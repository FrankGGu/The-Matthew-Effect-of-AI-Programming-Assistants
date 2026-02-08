func minOperations(X int, Y int) int {
    return abs(X - Y)
}

func abs(n int) int {
    if n < 0 {
        return -n
    }
    return n
}