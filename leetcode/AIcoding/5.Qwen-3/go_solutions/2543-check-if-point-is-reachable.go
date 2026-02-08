package main

func isReachable(targetX int, targetY int) bool {
    for targetX > 0 && targetY > 0 {
        if targetX == 1 || targetY == 1 {
            return true
        }
        if targetX > targetY {
            targetX %= targetY
        } else {
            targetY %= targetX
        }
    }
    return targetX == 0 || targetY == 0
}