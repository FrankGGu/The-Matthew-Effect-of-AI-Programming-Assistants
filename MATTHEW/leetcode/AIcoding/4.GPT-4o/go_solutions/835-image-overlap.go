func largestOverlap(A [][]int, B [][]int) int {
    n := len(A)
    count := make(map[[2]int]int)
    maxOverlap := 0

    for i := 0; i < n; i++ {
        for j := 0; j < n; j++ {
            if A[i][j] == 1 {
                for k := 0; k < n; k++ {
                    for l := 0; l < n; l++ {
                        if B[k][l] == 1 {
                            count[[2]int{k - i, l - j}]++
                            maxOverlap = max(maxOverlap, count[[2]int{k - i, l - j}])
                        }
                    }
                }
            }
        }
    }

    return maxOverlap
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}