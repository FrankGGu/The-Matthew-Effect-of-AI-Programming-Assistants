func flipgame(fronts []int, backs []int) int {
    unique := make(map[int]struct{})
    for i := range fronts {
        unique[fronts[i]] = struct{}{}
        unique[backs[i]] = struct{}{}
    }

    min := 10001
    for i := range fronts {
        if fronts[i] == backs[i] {
            continue
        }
        if _, ok := unique[backs[i]]; ok {
            continue
        }
        if fronts[i] < min {
            min = fronts[i]
        }
    }

    return min % 10001
}