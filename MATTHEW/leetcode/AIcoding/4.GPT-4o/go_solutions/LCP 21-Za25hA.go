func chaseGame(players [][]int) bool {
    a, b := players[0], players[1]
    dist := a[0]*a[0] + a[1]*a[1]
    speedA := a[2]
    speedB := b[2]

    if speedA <= speedB {
        return dist <= (speedB*speedB)/(speedA*speedA)
    }

    return dist <= (speedA*speedA)/(speedB*speedB)
}