package main

func pathExists(grid [][]int, m, n int) bool {
    // If the start or end cell is 0, no path can exist through it.
    if grid[0][0] == 0 || grid[m-1][n-1] == 0 {
        return false
    }

    dp := make([][]bool, m)
    for i := range dp {
        dp[i] = make([]bool, n)
    }

    // Base case: (0,0) is reachable from itself if grid[0][0] is 1.
    // This condition is already checked above, so dp[0][0] can be set to true.
    dp[0][0] = true

    // Fill the DP table
    for r := 0; r < m; r++ {
        for c := 0; c < n; c++ {
            // If the current cell is 0, no path can pass through it.
            if grid[r][c] == 0 {
                continue
            }
            // Skip (0,0) as it's the base case.
            if r == 0 && c == 0 {
                continue
            }

            // A cell (r,c) is reachable if grid[r][c] is 1 AND
            // it can be reached either from (r-1,c) or from (r,c-1).
            fromUp := false
            if r > 0 && dp[r-1][c] {
                fromUp = true
            }

            fromLeft := false
            if c > 0 && dp[r][c-1] {
                fromLeft = true
            }

            dp[r][c] = fromUp || fromLeft
        }
    }

    // The path exists if (m-1, n-1) is reachable.
    return dp[m-1][n-1]
}

func isPathDisconnected(grid [][]int) bool {
    m := len(grid)
    n := len(grid[0])

    // First, check if no path exists initially (0 flips needed).
    // This handles cases where grid[0][0] or grid[m-1][n-1] are initially 0,
    // or if the grid simply has no path from (0,0) to (m-1,n-1).
    if !pathExists(grid, m, n) {
        return true
    }

    // If a path exists, try flipping each cell (from 1 to 0) one by one.
    // We iterate through all cells, including (0,0) and (m-1,n-1),
    // as flipping them would also disconnect paths.
    for r := 0; r < m; r++ {
        for c := 0; c < n; c++ {
            // Only flip cells that are currently 1.
            if grid[r][c] == 1 {
                grid[r][c] = 0 // Temporarily flip 1 to 0

                // Check if flipping this cell disconnects all paths.
                if !pathExists(grid, m, n) {
                    return true // Found a single flip that disconnects all paths.
                }

                grid[r][c] = 1 // Restore the cell to its original value for the next iteration.
            }
        }
    }

    // If no single flip (including 0 flips, handled above) could disconnect all paths,
    // then it's not possible.
    return false
}