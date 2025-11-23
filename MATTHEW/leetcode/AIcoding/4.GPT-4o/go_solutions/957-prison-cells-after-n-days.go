func prisonAfterNDays(cells []int, N int) []int {
    seen := make(map[string]int)
    var result []int
    for day := 0; day < N; day++ {
        next := make([]int, 8)
        for i := 1; i < 7; i++ {
            next[i] = 1 - (cells[i-1] ^ cells[i+1])
        }
        cells = next
        key := fmt.Sprint(cells)
        if idx, ok := seen[key]; ok {
            cycle := day - idx
            remainingDays := (N - day) % cycle
            for i := 0; i < remainingDays; i++ {
                next = make([]int, 8)
                for j := 1; j < 7; j++ {
                    next[j] = 1 - (cells[j-1] ^ cells[j+1])
                }
                cells = next
            }
            return cells
        }
        seen[key] = day
    }
    return cells
}