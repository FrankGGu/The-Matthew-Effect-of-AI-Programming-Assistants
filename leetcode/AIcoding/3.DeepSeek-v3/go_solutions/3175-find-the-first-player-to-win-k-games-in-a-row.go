func findWinningPlayer(skills []int, k int) int {
    n := len(skills)
    if k >= n {
        maxSkill := skills[0]
        maxIdx := 0
        for i := 1; i < n; i++ {
            if skills[i] > maxSkill {
                maxSkill = skills[i]
                maxIdx = i
            }
        }
        return maxIdx
    }

    currentWinner := 0
    winStreak := 0

    for i := 1; i < n; i++ {
        if skills[currentWinner] > skills[i] {
            winStreak++
        } else {
            currentWinner = i
            winStreak = 1
        }
        if winStreak == k {
            return currentWinner
        }
    }

    return currentWinner
}