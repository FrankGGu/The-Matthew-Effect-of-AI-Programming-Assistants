func circularGameLosers(n int, k int) []int {
    visited := make([]bool, n)
    curr := 0
    step := k
    for !visited[curr] {
        visited[curr] = true
        curr = (curr + step) % n
        step += k
    }
    losers := []int{}
    for i := 0; i < n; i++ {
        if !visited[i] {
            losers = append(losers, i+1)
        }
    }
    return losers
}