func countArrangement(n int) int {
    count := 0
    visited := make([]bool, n+1)
    var backtrack func(int)
    backtrack = func(pos int) {
        if pos > n {
            count++
            return
        }
        for i := 1; i <= n; i++ {
            if !visited[i] && (i%pos == 0 || pos%i == 0) {
                visited[i] = true
                backtrack(pos + 1)
                visited[i] = false
            }
        }
    }
    backtrack(1)
    return count
}