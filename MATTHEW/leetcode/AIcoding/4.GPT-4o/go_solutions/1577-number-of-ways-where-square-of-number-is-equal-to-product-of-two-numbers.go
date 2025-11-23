func countWays(n int) int {
    count := 0
    for x := 1; x*x <= n; x++ {
        if n%x == 0 {
            y := n / x
            if x == y {
                count++
            } else {
                count += 2
            }
        }
    }
    return count
}