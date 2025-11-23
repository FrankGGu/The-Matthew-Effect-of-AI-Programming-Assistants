func countArrangement(N int) int {
    count := 0
    used := make([]bool, N+1)
    var backtrack func(pos int)
    backtrack = func(pos int) {
        if pos > N {
            count++
            return
        }
        for i := 1; i <= N; i++ {
            if !used[i] && (i%pos == 0 || pos%i == 0) {
                used[i] = true
                backtrack(pos + 1)
                used[i] = false
            }
        }
    }
    backtrack(1)
    return count
}