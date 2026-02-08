func numberOfChild(n int, k int) int {
    pos := 0
    direction := 1
    for i := 0; i < k; i++ {
        pos += direction
        if pos == 0 || pos == n-1 {
            direction *= -1
        }
    }
    return pos
}