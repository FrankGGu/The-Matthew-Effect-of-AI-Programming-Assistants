func countCollisions(directions string) int {
    count := 0
    n := len(directions)

    for i := 0; i < n; i++ {
        if directions[i] == 'S' {
            continue
        }
        if i > 0 && directions[i] == 'L' && directions[i-1] == 'R' {
            count += 2
            directions = directions[:i-1] + "SS" + directions[i+1:]
            i--
        } else if i < n-1 && directions[i] == 'R' && directions[i+1] == 'L' {
            count += 2
            directions = directions[:i] + "S" + directions[i+1:]
            i++
        }
    }

    for i := 0; i < n; i++ {
        if directions[i] == 'S' {
            count++
        }
    }

    return count
}