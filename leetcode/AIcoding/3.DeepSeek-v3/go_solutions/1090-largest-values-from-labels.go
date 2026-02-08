func largestValsFromLabels(values []int, labels []int, numWanted int, useLimit int) int {
    type item struct {
        value, label int
    }
    items := make([]item, len(values))
    for i := range values {
        items[i] = item{values[i], labels[i]}
    }
    sort.Slice(items, func(i, j int) bool {
        return items[i].value > items[j].value
    })

    labelCount := make(map[int]int)
    res := 0
    count := 0

    for _, it := range items {
        if count >= numWanted {
            break
        }
        if labelCount[it.label] < useLimit {
            res += it.value
            labelCount[it.label]++
            count++
        }
    }
    return res
}