func addRungs(rungs []int, dist int) int {
    res := 0
    prev := 0
    for _, rung := range rungs {
        diff := rung - prev
        if diff > dist {
            res += (diff - 1) / dist
        }
        prev = rung
    }
    return res
}