func findPeakGrid(mat [][]int) []int {
    m, n := len(mat), len(mat[0])
    low, high := 0, m-1

    for low <= high {
        mid := low + (high - low) / 2
        maxCol := 0
        for j := 1; j < n; j++ {
            if mat[mid][j] > mat[mid][maxCol] {
                maxCol = j
            }
        }

        if mid > 0 && mat[mid-1][maxCol] > mat[mid][maxCol] {
            high = mid - 1
        } else if mid < m-1 && mat[mid+1][maxCol] > mat[mid][maxCol] {
            low = mid + 1
        } else {
            return []int{mid, maxCol}
        }
    }

    return []int{-1, -1}
}