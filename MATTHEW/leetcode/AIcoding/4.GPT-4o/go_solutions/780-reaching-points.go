func canReach(x int, y int, targetX int, targetY int) bool {
    for targetX >= x && targetY >= y {
        if targetX == x && targetY == y {
            return true
        }
        if targetX > targetY {
            targetX -= targetY * ((targetX - x) / targetY)
        } else {
            targetY -= targetX * ((targetY - y) / targetX)
        }
    }
    return false
}