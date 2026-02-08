package main

func imageSmoother(img [][]int) [][]int {
    rows := len(img)
    cols := len(img[0])
    result := make([][]int, rows)
    for i := range result {
        result[i] = make([]int, cols)
    }

    for i := 0; i < rows; i++ {
        for j := 0; j < cols; j++ {
            total := 0
            count := 0
            for x := i - 1; x <= i+1; x++ {
                for y := j - 1; y <= j+1; y++ {
                    if x >= 0 && x < rows && y >= 0 && y < cols {
                        total += img[x][y]
                        count++
                    }
                }
            }
            result[i][j] = total / count
        }
    }
    return result
}