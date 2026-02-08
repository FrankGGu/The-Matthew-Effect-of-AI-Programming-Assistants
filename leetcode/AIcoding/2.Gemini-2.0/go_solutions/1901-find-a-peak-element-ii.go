func findPeakGrid(mat [][]int) []int {
    m := len(mat)
    n := len(mat[0])

    low := 0
    high := m - 1

    for low <= high {
        mid := low + (high - low) / 2

        maxCol := 0
        for i := 1; i < n; i++ {
            if mat[mid][i] > mat[mid][maxCol] {
                maxCol = i
            }
        }

        if mid > 0 && mat[mid][maxCol] < mat[mid-1][maxCol] {
            high = mid - 1
        } else if mid < m - 1 && mat[mid][maxCol] < mat[mid+1][maxCol] {
            low = mid + 1
        } else {
            return []int{mid, maxCol}
        }
    }

    return []int{-1, -1}
}