package main

func queensAttacktheKing(queens [][]int, king []int) [][]int {
    directions := [][2]int{{-1, -1}, {-1, 0}, {-1, 1}, {0, -1}, {0, 1}, {1, -1}, {1, 0}, {1, 1}}
    result := [][]int{}
    queenSet := make(map[[2]int]bool)
    for _, q := range queens {
        queenSet[[2]int{q[0], q[1]}] = true
    }
    for _, d := range directions {
        x, y := king[0], king[1]
        for x >= 0 && x < 8 && y >= 0 && y < 8 {
            x += d[0]
            y += d[1]
            if queenSet[[2]int{x, y}] {
                result = append(result, []int{x, y})
                break
            }
        }
    }
    return result
}