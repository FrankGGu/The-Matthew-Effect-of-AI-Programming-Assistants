func numMovesStones(a int, b int, c int) []int {
    stones := []int{a, b, c}
    sort.Ints(stones)
    minMoves, maxMoves := 0, stones[2]-stones[0]-2

    if stones[0] + 1 == stones[1] && stones[1] + 1 == stones[2] {
        minMoves = 0
    } else if stones[0] + 1 == stones[1] || stones[1] + 1 == stones[2] || stones[0] + 2 == stones[2] {
        minMoves = 1
    } else {
        minMoves = 2
    }

    return []int{minMoves, maxMoves}
}