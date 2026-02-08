func minFallingPathSum(matrix [][]int) int {
    n := len(matrix)

    // Start from the second row (index 1)
    for i := 1; i < n; i++ {
        for j := 0; j < n; j++ {
            // Calculate the minimum sum from the previous row