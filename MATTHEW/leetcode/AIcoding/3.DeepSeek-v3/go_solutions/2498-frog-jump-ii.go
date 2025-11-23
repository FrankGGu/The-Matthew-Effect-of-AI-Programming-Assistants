func maxJump(stones []int) int {
    max := 0
    for i := 2; i < len(stones); i++ {
        if stones[i] - stones[i-2] > max {
            max = stones[i] - stones[i-2]
        }
    }
    return max
}