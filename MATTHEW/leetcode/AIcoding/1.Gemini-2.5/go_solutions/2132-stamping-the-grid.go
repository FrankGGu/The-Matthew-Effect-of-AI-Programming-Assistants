func possibleToStamp(grid [][]int, stampHeight int, stampWidth int) bool {
    R := len(grid)
    C := len(grid[0])

    // Step 1: Precompute 2D prefix sums for the original grid.
    // prefixSum[r][c] stores the sum of grid[i][j] for 0 <= i < r and 0 <= j < c.
    // This helps efficiently check if a rectangular area contains only 0s.
    prefixSum := make([][]int, R+1)
    for i := range prefixSum {
        prefixSum[i] = make([]int, C+1)
    }

    for r := 0; r < R; r++ {
        for c := 0; c < C; c++ {
            prefixSum[r+1][c+1] = prefixSum[r][c+1] + prefixSum[r+1][c] - prefixSum[r][c] + grid[r][c]
        }
    }

    // Helper function to get the sum of a rectangle (r1, c1) to (r2, c2) (inclusive).
    getRectSum := func(r1, c1, r2, c2 int) int {
        return prefixSum[r2+1][c2+1] - prefixSum[r1][c2+1] - prefixSum[r2+1][c1] + prefixSum[r1][c1]
    }

    // Step 2: Identify all valid stamp placements.
    // canPlace[r][c] is true if a stamp can be placed with its top-left corner at (r, c).
    // A stamp can be placed if the entire stamp area (r, c) to (r + stampHeight - 1, c + stampWidth - 1)
    // consists only of 0s (i.e., its sum is 0).
    canPlace := make([][]bool, R)
    for i := range canPlace {
        canPlace[i] = make([]bool, C)
    }

    for r := 0; r <= R-stampHeight; r++ {
        for c := 0; c <= C-stampWidth; c++ {
            if getRectSum(r, c, r+stampHeight-1, c+stampWidth-1) == 0 {
                canPlace[r][c] = true
            }
        }
    }

    // Step 3 & 4: Use a 2D difference array to count how many valid stamps cover each cell.
    // diff[r][c] will store the net effect of stamp placements at (r,c).
    // After computing 2D prefix sums on 'diff', diff[r][c] will represent the total
    // number of stamps covering cell (r, c).
    diff := make([][]int, R+1)
    for i := range diff {
        diff[i] = make([]int, C+1)
    }

    for r := 0; r <= R-stampHeight; r++ {
        for c := 0; c <= C-stampWidth; c++ {
            if canPlace[r][c] {
                // A stamp placed at (r, c) covers the rectangle
                // (r, c) to (r + stampHeight - 1, c + stampWidth - 1).
                // Apply difference array updates:
                diff[r][c]++
                diff[r+stampHeight][c]--
                diff[r][c+stampWidth]--
                diff[r+stampHeight][c+stampWidth]++
            }
        }
    }

    // Compute 2D prefix sums on the 'diff' array to get the actual covered counts for each cell.
    for r := 0; r < R; r++ {
        for c := 0; c < C; c++ {
            if r > 0 {
                diff[r][c] += diff[r-1][c]
            }
            if c > 0 {
                diff[r][c] += diff[r][c-1]
            }
            if r > 0 && c > 0 {
                diff[r][c] -= diff[r-1][c-1]
            }
        }
    }

    // Step 5: Final check.
    // Iterate through the original grid. If a '0' cell is not covered by any stamp,
    // then it's impossible to stamp the grid.
    for r := 0; r < R; r++ {
        for c := 0; c < C; c++ {
            if grid[r][c] == 0 && diff[r][c] == 0 {
                return false // A '0' cell is not covered
            }
        }
    }

    return true // All '0' cells are covered
}