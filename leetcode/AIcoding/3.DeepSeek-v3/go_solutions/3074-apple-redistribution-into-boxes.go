func minimumBoxes(apple []int, capacity []int) int {
    totalApples := 0
    for _, a := range apple {
        totalApples += a
    }

    sort.Sort(sort.Reverse(sort.IntSlice(capacity)))

    boxes := 0
    sum := 0
    for _, cap := range capacity {
        sum += cap
        boxes++
        if sum >= totalApples {
            return boxes
        }
    }

    return boxes
}