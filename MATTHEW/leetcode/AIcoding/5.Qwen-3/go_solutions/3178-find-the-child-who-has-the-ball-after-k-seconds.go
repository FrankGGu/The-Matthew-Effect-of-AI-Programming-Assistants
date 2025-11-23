package main

func numberOfPlayers(k int) int {
    players := 1
    for i := 0; i < k; i++ {
        players = (players + 1) % 2
    }
    return players
}