func maximumTotalReward(operations [][]int) int {
    totalReward := 0
    rewardMap := make(map[int]int)

    for _, op := range operations {
        if op[0] == 1 {
            totalReward += op[1]
        } else if op[0] == 2 {
            rewardMap[op[1]]++
        }
    }

    for _, count := range rewardMap {
        totalReward += count
    }

    return totalReward
}