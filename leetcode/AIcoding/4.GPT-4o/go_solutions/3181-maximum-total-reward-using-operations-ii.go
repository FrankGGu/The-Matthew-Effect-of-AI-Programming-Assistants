func maxReward(operations [][]int) int {
    totalReward := 0
    for _, op := range operations {
        totalReward += op[0] * op[1]
    }
    return totalReward
}