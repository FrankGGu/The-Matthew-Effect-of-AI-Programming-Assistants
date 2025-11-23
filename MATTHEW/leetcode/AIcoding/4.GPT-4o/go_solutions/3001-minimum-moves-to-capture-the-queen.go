func minQueenMoves(queenPos []int, targetPos []int) int {
    if queenPos[0] == targetPos[0] || queenPos[1] == targetPos[1] || 
       abs(queenPos[0]-targetPos[0]) == abs(queenPos[1]-targetPos[1]) {
        return 1
    }
    return 2
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}