func queensAttacktheKing(queens [][]int, king []int) [][]int {
    directions := [][]int{
        {-1, 0}, {-1, -1}, {-1, 1}, {0, -1}, {0, 1}, {1, 0}, {1, -1}, {1, 1},
    }

    queenSet := make(map[[2]int]bool)
    for _, queen := range queens {
        queenSet[[2]int{queen[0], queen[1]}] = true
    }

    result := [][]int{}

    for _, dir := range directions {
        x, y := king[0], king[1]
        for {
            x += dir[0]
            y += dir[1]
            if x < 0 || x >= 8 || y < 0 || y >= 8 {
                break
            }
            if queenSet[[2]int{x, y}] {
                result = append(result, []int{x, y})
                break
            }
        }
    }

    return result
}