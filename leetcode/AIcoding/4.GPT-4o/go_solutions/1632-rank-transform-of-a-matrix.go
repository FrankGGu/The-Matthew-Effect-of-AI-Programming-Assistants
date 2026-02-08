func matrixRankTransform(matrix [][]int) [][]int {
    if len(matrix) == 0 || len(matrix[0]) == 0 {
        return [][]int{}
    }

    rows, cols := len(matrix), len(matrix[0])
    nums := make([][3]int, 0)

    for r := 0; r < rows; r++ {
        for c := 0; c < cols; c++ {
            nums = append(nums, [3]int{matrix[r][c], r, c})
        }
    }

    sort.Slice(nums, func(i, j int) bool {
        return nums[i][0] < nums[j][0]
    })

    rank := make([][]int, rows)
    for i := range rank {
        rank[i] = make([]int, cols)
    }

    rowRank := make([]int, rows)
    colRank := make([]int, cols)

    for _, num := range nums {
        value, r, c := num[0], num[1], num[2]
        maxRank := max(rowRank[r], colRank[c])
        rank[r][c] = maxRank + 1
        rowRank[r] = rank[r][c]
        colRank[c] = rank[r][c]
    }

    return rank
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}