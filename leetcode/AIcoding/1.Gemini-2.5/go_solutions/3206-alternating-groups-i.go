func numberOfAlternatingGroups(colors []int) int {
    n := len(colors)
    count := 0
    for i := 0; i < n; i++ {
        c1 := colors[i]
        c2 := colors[(i + 1) % n]
        c3 := colors[(i + 2) % n]

        if c1 != c2 && c2 != c3 {
            count++
        }
    }
    return count
}