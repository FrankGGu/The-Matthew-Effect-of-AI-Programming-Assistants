func numberOfWeeks(milestones []int) int64 {
    max := 0
    sum := int64(0)
    for _, m := range milestones {
        if m > max {
            max = m
        }
        sum += int64(m)
    }
    rest := sum - int64(max)
    if int64(max) > rest + 1 {
        return 2 * rest + 1
    }
    return sum
}