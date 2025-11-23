func findDiagonalOrder(nums [][]int) []int {
    result := []int{}
    diagonals := map[int][]int{}

    for i := 0; i < len(nums); i++ {
        for j := 0; j < len(nums[i]); j++ {
            diagonals[i+j] = append(diagonals[i+j], nums[i][j])
        }
    }

    for k := len(diagonals) - 1; k >= 0; k-- {
        result = append(result, diagonals[k]...)
    }

    return result
}