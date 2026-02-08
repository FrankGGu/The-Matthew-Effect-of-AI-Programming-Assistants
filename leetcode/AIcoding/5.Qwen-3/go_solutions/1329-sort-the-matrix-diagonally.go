package main

func diagonalSort(nums [][]int) [][]int {
    m := len(nums)
    n := len(nums[0])

    for i := 0; i < m; i++ {
        sortDiagonal(nums, i, 0, m, n)
    }

    for j := 1; j < n; j++ {
        sortDiagonal(nums, 0, j, m, n)
    }

    return nums
}

func sortDiagonal(nums [][]int, startRow, startCol, m, n int) {
    var diag []int
    r, c := startRow, startCol
    for r < m && c < n {
        diag = append(diag, nums[r][c])
        r++
        c++
    }

    sort.Ints(diag)

    r, c = startRow, startCol
    idx := 0
    for r < m && c < n {
        nums[r][c] = diag[idx]
        idx++
        r++
        c++
    }
}