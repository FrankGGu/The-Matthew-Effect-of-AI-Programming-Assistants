func circularGameLosers(n int, k int) []int {
    visited := make([]bool, n)
    current := 0
    step := 1
    for !visited[current] {
        visited[current] = true
        current = (current + step * k) % n
        step++
    }
    losers := []int{}
    for i := 0; i < n; i++ {
        if !visited[i] {
            losers = append(losers, i+1)
        }
    }
    return losers
}