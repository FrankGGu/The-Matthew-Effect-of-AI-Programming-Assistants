func escapeGhosts(ghosts [][]int, target []int) bool {
    distToTarget := abs(target[0]) + abs(target[1])
    for _, ghost := range ghosts {
        if abs(ghost[0]-target[0])+abs(ghost[1]-target[1]) <= distToTarget {
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