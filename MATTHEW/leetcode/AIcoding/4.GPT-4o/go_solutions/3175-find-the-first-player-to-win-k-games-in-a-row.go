func findTheWinner(players []int, k int) int {
    n := len(players)
    if n == 0 {
        return -1
    }

    wins := make([]int, n)
    count := 0
    idx := 0

    for count < n {
        if wins[idx] < k {
            wins[idx]++
            if wins[idx] == k {
                return players[idx]
            }
            count++
        }
        idx = (idx + 1) % n
    }

    return -1
}