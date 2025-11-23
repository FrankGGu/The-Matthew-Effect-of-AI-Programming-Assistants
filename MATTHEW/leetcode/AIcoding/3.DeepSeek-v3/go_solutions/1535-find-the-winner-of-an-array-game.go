func getWinner(arr []int, k int) int {
    currentWinner := arr[0]
    winStreak := 0

    for i := 1; i < len(arr); i++ {
        if arr[i] > currentWinner {
            currentWinner = arr[i]
            winStreak = 1
        } else {
            winStreak++
        }

        if winStreak == k {
            return currentWinner
        }
    }

    return currentWinner
}