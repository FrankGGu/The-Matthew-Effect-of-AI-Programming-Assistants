func maximumEvenSplit(finalSum int64) []int64 {
    if finalSum % 2 != 0 {
        return []int64{}
    }
    res := []int64{}
    current := int64(2)
    remaining := finalSum
    for remaining >= current {
        res = append(res, current)
        remaining -= current
        current += 2
    }
    if remaining > 0 {
        res[len(res)-1] += remaining
    }
    return res
}