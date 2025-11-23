func maxJump(stones []int) int {
    maxJump := 0
    for i := 1; i < len(stones); i++ {
        jump := stones[i] - stones[i-1]
        if jump > maxJump {
            maxJump = jump
        }
    }
    return maxJump
}