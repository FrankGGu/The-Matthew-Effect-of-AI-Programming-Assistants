func findPeakGrid(mat [][]int) []int {
    if len(mat) == 0 || len(mat[0]) == 0 {
        return nil
    }
    n, m := len(mat), len(mat[0])
    left, right := 0, m-1

    for left < right {
        mid := left + (right-left)/2
        maxRow := 0
        for i := 1; i < n; i++ {
            if mat[i][mid] > mat[maxRow][mid] {
                maxRow = i
            }
        }
        if mid < m-1 && mat[maxRow][mid] < mat[maxRow][mid+1] {
            left = mid + 1
        } else {
            right = mid
        }
    }

    return []int{maxRow, left}
}