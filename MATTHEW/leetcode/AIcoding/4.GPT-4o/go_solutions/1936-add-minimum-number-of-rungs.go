func addRungs(rungs []int, dist int) int {
    count := 0
    current := 0

    for _, rung := range rungs {
        if rung > current + dist {
            needed := (rung - current - 1) / dist
            count += needed
        }
        current = rung
    }

    return count
}