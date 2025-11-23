func numMovesStones(a int, b int, c int) []int {
    x, y, z := a, b, c
    if x > y {
        x, y = y, x
    }
    if x > z {
        x, z = z, x
    }
    if y > z {
        y, z = z, y
    }

    minMoves := 0
    if z - x == 2 {
        minMoves = 0
    } else if y - x <= 2 || z - y <= 2 {
        minMoves = 1
    } else {
        minMoves = 2
    }

    maxMoves := z - x - 2

    return []int{minMoves, maxMoves}
}