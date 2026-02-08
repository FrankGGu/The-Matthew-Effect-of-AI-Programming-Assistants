func numberOfWeeks(milestones []int) int64 {
    var sum int64
    var maxVal int
    for _, v := range milestones {
        sum += int64(v)
        if v > maxVal {
            maxVal = v
        }
    }

    remaining := sum - int64(maxVal)

    if int64(maxVal) > remaining {
        return remaining*2 + 1
    } else {
        return sum
    }
}