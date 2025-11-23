func isPathCrossing(path string) bool {
    visited := make(map[[2]int]bool)
    x, y := 0, 0
    visited[[2]int{x, y}] = true

    for _, dir := range path {
        switch dir {
        case 'N':
            y++
        case 'S':
            y--
        case 'E':
            x++
        case 'W':
            x--
        }
        if visited[[2]int{x, y}] {
            return true
        }
        visited[[2]int{x, y}] = true
    }
    return false
}