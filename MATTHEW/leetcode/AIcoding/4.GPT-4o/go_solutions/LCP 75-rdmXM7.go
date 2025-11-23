func canReach(target int, maxJump int) bool {
    if target < 0 {
        target = -target
    }
    return target <= maxJump * (maxJump + 1) / 2
}