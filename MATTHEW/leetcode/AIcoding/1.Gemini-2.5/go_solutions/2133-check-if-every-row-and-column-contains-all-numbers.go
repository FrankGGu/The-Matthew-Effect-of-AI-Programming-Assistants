func checkValid(matrix [][]int) bool {
    n := len(matrix)

    // Check each row
    for i := 0; i < n; i++ {
        seen := make([]bool, n+1) // Using a boolean array for numbers 1 to n
        for j := 0; j < n; j++ {