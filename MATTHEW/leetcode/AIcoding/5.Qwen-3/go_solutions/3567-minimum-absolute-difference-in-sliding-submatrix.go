package main

func minAbsoluteDifference(mat [][]int, k int) int {
    rows := len(mat)
    cols := len(mat[0])
    if k == 0 {
        return 0
    }
    var minDiff int = 1<<31 - 1
    for i := 0; i <= rows-k; i++ {
        for j := 0; j <= cols-k; j++ {
            submatrix := make([]int, 0)
            for x := i; x < i+k; x++ {
                for y := j; y < j+k; y++ {
                    submatrix = append(submatrix, mat[x][y])
                }
            }
            sort.Ints(submatrix)
            diff := 0
            for m := 1; m < len(submatrix); m++ {
                if submatrix[m]-submatrix[m-1] < diff {
                    diff = submatrix[m] - submatrix[m-1]
                }
            }
            if diff < minDiff {
                minDiff = diff
            }
        }
    }
    return minDiff
}