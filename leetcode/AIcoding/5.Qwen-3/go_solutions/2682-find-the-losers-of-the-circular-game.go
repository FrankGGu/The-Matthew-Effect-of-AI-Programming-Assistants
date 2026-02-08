package main

func losingPlayer(n int, k int) []int {
    players := make([]int, n)
    for i := 0; i < n; i++ {
        players[i] = i + 1
    }

    idx := 0
    for len(players) > 1 {
        idx = (idx + k - 1) % len(players)
        players = append(players[:idx], players[idx+1:]...)
    }

    return players
}