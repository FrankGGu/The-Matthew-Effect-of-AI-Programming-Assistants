func getWinner(arr []int, k int) int {
    n := len(arr)
    if k >= n {
        return max(arr)
    }

    currentWinner := arr[0]
    consecutiveWins := 0

    for i := 1; i < n; i++ {
        if arr[i] > currentWinner {
            currentWinner = arr[i]
            consecutiveWins = 1
        } else {
            consecutiveWins++
        }

        if consecutiveWins == k {
            return currentWinner
        }
    }

    return currentWinner
}

func max(arr []int) int {
    maxVal := arr[0]
    for _, v := range arr {
        if v > maxVal {
            maxVal = v
        }
    }
    return maxVal
}