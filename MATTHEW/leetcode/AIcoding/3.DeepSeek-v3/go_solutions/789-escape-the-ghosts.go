func escapeGhosts(ghosts [][]int, target []int) bool {
    playerDist := abs(target[0]) + abs(target[1])
    for _, ghost := range ghosts {
        ghostDist := abs(ghost[0]-target[0]) + abs(ghost[1]-target[1])
        if ghostDist <= playerDist {
            return false
        }
    }
    return true
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}