func findTheChild(n int, k int) int {
    return (k % (2*n-2) + n) % n
}