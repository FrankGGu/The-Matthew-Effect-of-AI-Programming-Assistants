func generate(numRows int) [][]int {
    if numRows == 0 {
        return [][]int{}
    }

    triangle := make([][]int, numRows)

    // First row is always [1]
    triangle[0] = []int{1}

    // Generate subsequent rows
    for i := 1; i < numRows; i++ {
        currentRow := make([]int, i+1)
        prevRow := triangle[i-1]

        // The first element of each row is always 1
        currentRow[0] = 1

        // Calculate interior elements
        for j := 1; j < i; j++ {
            currentRow[j] = prevRow[j-1] + prevRow[j]
        }

        // The last element of each row is always 1
        currentRow[i] = 1

        triangle[i] = currentRow
    }

    return triangle
}