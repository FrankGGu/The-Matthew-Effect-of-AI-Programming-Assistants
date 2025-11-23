func rightTriangles(grid [][]int) int64 {
    rows := len(grid)
    cols := len(grid[0])

    rowCounts := make([]int, rows)
    colCounts := make([]int, cols)

    // First pass: Populate rowCounts and colCounts
    for r := 0; r < rows; r++ {
        for c := 0; c < cols; c++ {
            if grid[r][c] == 1 {
                rowCounts[r]++
                colCounts[c]++
            }
        }
    }

    var totalTriangles int64 = 0

    // Second pass: Calculate right triangles
    for r := 0; r < rows; r++ {
        for c := 0; c < cols; c++ {
            if grid[r][c] == 1 {
                // For a '1' at (r, c) to be the right angle vertex,
                // it needs at least one other '1' in the same row
                // and at least one other '1' in the same column.

                // Number of other '1's in the same row
                horizontalPartners := rowCounts[r] - 1

                // Number of other '1's in the same column
                verticalPartners := colCounts[c] - 1

                if horizontalPartners > 0 && verticalPartners > 0 {
                    totalTriangles += int