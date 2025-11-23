func maximumRows(matrix [][]int, numSelect int) int {
    m := len(matrix)
    if m == 0 {
        return 0
    }
    n := len(matrix[0])
    maxRows := 0

    var backtrack func(pos, selected int, cols []int)
    backtrack = func(pos, selected int, cols []int) {
        if selected == numSelect {
            covered := 0
            for i := 0; i < m; i++ {
                rowCovered := true
                for j := 0; j < n; j++ {
                    if matrix[i][j] == 1 && !contains(cols, j) {
                        rowCovered = false
                        break
                    }
                }
                if rowCovered {
                    covered++
                }
            }
            if covered > maxRows {
                maxRows = covered
            }
            return
        }
        if pos >= n {
            return
        }
        backtrack(pos+1, selected, cols)
        backtrack(pos+1, selected+1, append(cols, pos))
    }

    backtrack(0, 0, []int{})
    return maxRows
}

func contains(arr []int, num int) bool {
    for _, v := range arr {
        if v == num {
            return true
        }
    }
    return false
}