func imageSmoother(M [][]int) [][]int {
    rows := len(M)
    if rows == 0 {
        return [][]int{}
    }
    cols := len(M[0])
    result := make([][]int, rows)
    for i := range result {
        result[i] = make([]int, cols)
    }

    directions := [][]int{
        {-1, -1}, {-1, 0}, {-1, 1},
        {0, -1},              {0, 0},  {0, 1},
        {1, -1}, {1, 0}, {1, 1},
    }

    for i := 0; i < rows; i++ {
        for j := 0; j < cols; j++ {
            sum := 0
            count := 0
            for _, d := range directions {
                ni, nj := i+d[0], j+d[1]
                if ni >= 0 && ni < rows && nj >= 0 && nj < cols {
                    sum += M[ni][nj]
                    count++
                }
            }
            result[i][j] = sum / count
        }
    }

    return result
}