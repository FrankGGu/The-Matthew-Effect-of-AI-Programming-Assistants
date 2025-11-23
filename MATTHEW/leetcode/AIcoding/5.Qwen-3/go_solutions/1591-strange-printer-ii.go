package main

func isPrintable(plate [][]int) bool {
    rows, cols := len(plate), len(plate[0])
    minRow, maxRow := make([]int, 16), make([]int, 16)
    minCol, maxCol := make([]int, 16), make([]int, 16)

    for i := 0; i < 16; i++ {
        minRow[i], minCol[i] = rows, cols
        maxRow[i], maxCol[i] = -1, -1
    }

    for i := 0; i < rows; i++ {
        for j := 0; j < cols; j++ {
            c := plate[i][j]
            minRow[c] = min(minRow[c], i)
            maxRow[c] = max(maxRow[c], i)
            minCol[c] = min(minCol[c], j)
            maxCol[c] = max(maxCol[c], j)
        }
    }

    for c := 0; c < 16; c++ {
        if minRow[c] == rows {
            continue
        }
        for i := minRow[c]; i <= maxRow[c]; i++ {
            for j := minCol[c]; j <= maxCol[c]; j++ {
                if plate[i][j] != c {
                    return false
                }
            }
        }
    }

    return true
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}