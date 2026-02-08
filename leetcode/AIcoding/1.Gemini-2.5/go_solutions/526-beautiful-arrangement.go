func countArrangement(n int) int {
    count := 0
    used := make([]bool, n+1)

    var backtrack func(pos int)
    backtrack = func(pos int) {
        if pos > n {
            count++
            return
        }

        for num := 1; num <= n; num++ {
            if !used[num] {
                if num%pos == 0 || pos%num == 0 {
                    used[num] = true
                    backtrack(pos + 1)
                    used[num] = false // Backtrack
                }
            }
        }
    }

    backtrack(1)
    return count
}