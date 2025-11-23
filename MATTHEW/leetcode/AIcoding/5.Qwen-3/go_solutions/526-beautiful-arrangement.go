package main

func countArrangement(n int) int {
    visited := make([]bool, n+1)
    var backtrack func(int) int
    backtrack = func(pos int) int {
        if pos > n {
            return 1
        }
        count := 0
        for i := 1; i <= n; i++ {
            if !visited[i] && (i%pos == 0 || pos%i == 0) {
                visited[i] = true
                count += backtrack(pos + 1)
                visited[i] = false
            }
        }
        return count
    }
    return backtrack(1)
}