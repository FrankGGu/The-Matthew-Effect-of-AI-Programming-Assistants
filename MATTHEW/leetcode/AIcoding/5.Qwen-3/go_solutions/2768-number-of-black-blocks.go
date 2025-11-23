package main

func countBlackBlocks(rows int, columns int, cells [][]int) int {
    blockMap := make(map[[2]int]int)
    for _, cell := range cells {
        r, c := cell[0], cell[1]
        for dr := 0; dr < 2; dr++ {
            for dc := 0; dc < 2; dc++ {
                if r+dr < rows && c+dc < columns {
                    block := [2]int{r + dr, c + dc}
                    blockMap[block]++
                }
            }
        }
    }
    count := 0
    for _, v := range blockMap {
        if v >= 4 {
            count++
        }
    }
    return count
}