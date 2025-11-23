type Board struct {
    stones map[[2]int]int // 1 for black, 2 for white
}

func (b *Board) placeStone(x, y, color int) bool {
    pos := [2]int{x, y}
    if _, exists := b.stones[pos]; exists {
        return false
    }
    b.stones[pos] = color
    return true
}

func (b *Board) checkWin(x, y, color int) bool {
    directions := [][2]int{{1, 0}, {0, 1}, {1, 1}, {1, -1}}
    for _, d := range directions {
        count := 1
        for i := 1; i <= 4; i++ {
            nx, ny := x+i*d[0], y+i*d[1]
            if b.stones[[2]int{nx, ny}] == color {
                count++
            } else {
                break
            }
        }
        for i := 1; i <= 4; i++ {
            nx, ny := x-i*d[0], y-i*d[1]
            if b.stones[[2]int{nx, ny}] == color {
                count++
            } else {
                break
            }
        }
        if count >= 5 {
            return true
        }
    }
    return false
}

func main() {
    moves := [][]int{{0, 0, 1}, {1, 0, 2}, {1, 1, 1}, {2, 0, 2}, {2, 1, 1}, {3, 0, 2}, {3, 1, 1}, {4, 0, 2}, {4, 1, 1}}
    board := Board{stones: make(map[[2]int]int)}
    for _, move := range moves {
        x, y, color := move[0], move[1], move[2]
        if !board.placeStone(x, y, color) {
            fmt.Println("Invalid move")
            continue
        }
        if board.checkWin(x, y, color) {
            if color == 1 {
                fmt.Println("Black wins")
            } else {
                fmt.Println("White wins")
            }
            return
        }
    }
    fmt.Println("No winner yet")
}