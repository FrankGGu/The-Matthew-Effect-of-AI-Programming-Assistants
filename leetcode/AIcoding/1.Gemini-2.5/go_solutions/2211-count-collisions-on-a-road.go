func countCollisions(directions string) int {
    n := len(directions)
    if n == 0 {
        return 0
    }

    left := 0
    for left < n && directions[left] == 'L' {
        left++
    }

    right := n - 1
    for right >= 0 && directions[right] == 'R' {
        right--
    }

    collisions := 0
    for i := left; i <= right; i++ {
        if directions[i] == 'R' || directions[i] == 'L' {
            collisions++
        }
    }

    return collisions
}