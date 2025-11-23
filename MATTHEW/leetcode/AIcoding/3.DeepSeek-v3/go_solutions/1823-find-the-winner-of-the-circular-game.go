func findTheWinner(n int, k int) int {
    friends := make([]int, n)
    for i := range friends {
        friends[i] = i + 1
    }
    pos := 0
    for len(friends) > 1 {
        pos = (pos + k - 1) % len(friends)
        friends = append(friends[:pos], friends[pos+1:]...)
    }
    return friends[0]
}