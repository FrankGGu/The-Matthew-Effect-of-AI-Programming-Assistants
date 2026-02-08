func minimumLevels(possible []int) int {
    n := len(possible)
    total := 0
    for _, num := range possible {
        if num == 1 {
            total += 1
        } else {
            total -= 1
        }
    }

    current := 0
    for i := 0; i < n-1; i++ {
        if possible[i] == 1 {
            current += 1
        } else {
            current -= 1
        }
        if current > total - current {
            return i + 1
        }
    }
    return -1
}