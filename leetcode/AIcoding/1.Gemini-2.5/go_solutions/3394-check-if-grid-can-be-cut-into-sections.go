func isPossibleToCut(grid [][]int) bool {
    m := len(grid)
    n := len(grid[0])

    checkSection := func(r1, c1, r2, c2 int) (bool, int) {
        if r1 > r2 || c1 > c2 {
            return false, -1
        }
        val := grid[r1][c1]
        for r := r1; r <= r2; r++ {
            for c := c1; c <= c2; c++ {
                if grid[r][c] != val {
                    return false, -1
                }
            }
        }
        return true, val
    }

    // Try horizontal cuts
    for r := 0; r < m-1; r++ {
        // Top section: (0, 0) to (r, n-1)
        ok1, val1 := checkSection(0, 0, r, n-1)
        if !ok1 {
            continue
        }

        // Bottom section: (r+1, 0) to (m-1, n-1)
        ok2, val2 := checkSection(r+1, 0, m-1, n-1)
        if !ok2 {
            continue
        }

        if val1 != val2 {
            return true
        }
    }

    // Try vertical cuts
    for c := 0; c < n-1; c++ {
        // Left section: (0, 0) to (m-1, c)
        ok1, val1 := checkSection(0, 0, m-1, c)
        if !ok1 {
            continue
        }

        // Right section: (0, c+1) to (m-1, n-1)
        ok2, val2 := checkSection(0, c+1, m-1, n-1)
        if !ok2 {
            continue
        }

        if val1 != val2 {
            return true
        }
    }

    return false
}