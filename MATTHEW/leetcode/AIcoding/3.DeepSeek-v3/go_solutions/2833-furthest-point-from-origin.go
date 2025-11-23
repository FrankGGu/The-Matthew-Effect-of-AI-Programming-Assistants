func furthestDistanceFromOrigin(moves string) int {
    left := 0
    right := 0
    any := 0

    for _, move := range moves {
        switch move {
        case 'L':
            left++
        case 'R':
            right++
        case '_':
            any++
        }
    }

    max := left
    if right > max {
        max = right
    }

    min := left
    if right < min {
        min = right
    }

    return max + any - min
}