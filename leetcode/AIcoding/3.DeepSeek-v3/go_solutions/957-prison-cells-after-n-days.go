func prisonAfterNDays(cells []int, N int) []int {
    seen := make(map[string]int)
    for i := 0; i < N; i++ {
        key := fmt.Sprint(cells)
        if day, ok := seen[key]; ok {
            cycle := i - day
            remaining := N - i
            return prisonAfterNDays(cells, remaining % cycle)
        }
        seen[key] = i
        next := make([]int, len(cells))
        for j := 1; j < len(cells)-1; j++ {
            if cells[j-1] == cells[j+1] {
                next[j] = 1
            } else {
                next[j] = 0
            }
        }
        cells = next
    }
    return cells
}