func findChampion(n int, matches [][]int) int {
    wins := make(map[int]int)
    losses := make(map[int]int)

    for _, match := range matches {
        wins[match[0]]++
        losses[match[1]]++
    }

    for i := 1; i <= n; i++ {
        if wins[i] == n-1 && losses[i] == 0 {
            return i
        }
    }

    return -1
}