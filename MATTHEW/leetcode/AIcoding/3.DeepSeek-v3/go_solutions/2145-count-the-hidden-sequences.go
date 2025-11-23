func numberOfArrays(differences []int, lower int, upper int) int {
    min, max := 0, 0
    current := 0
    for _, diff := range differences {
        current += diff
        if current < min {
            min = current
        }
        if current > max {
            max = current
        }
    }
    total := (upper - lower) - (max - min) + 1
    if total < 0 {
        return 0
    }
    return total
}