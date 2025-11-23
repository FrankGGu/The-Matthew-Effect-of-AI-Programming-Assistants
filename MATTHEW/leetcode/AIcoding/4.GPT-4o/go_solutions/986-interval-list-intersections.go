func intervalIntersection(A [][]int, B [][]int) [][]int {
    i, j := 0, 0
    var result [][]int

    for i < len(A) && j < len(B) {
        start := max(A[i][0], B[j][0])
        end := min(A[i][1], B[j][1])
        if start <= end {
            result = append(result, []int{start, end})
        }
        if A[i][1] < B[j][1] {
            i++
        } else {
            j++
        }
    }

    return result
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}