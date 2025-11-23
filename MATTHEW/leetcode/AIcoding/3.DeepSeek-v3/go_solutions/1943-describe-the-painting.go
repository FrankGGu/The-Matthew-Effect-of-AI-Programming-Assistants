func splitPainting(segments [][]int) [][]int64 {
    events := make(map[int]int64)
    for _, seg := range segments {
        start, end, color := seg[0], seg[1], int64(seg[2])
        events[start] += color
        events[end] -= color
    }

    keys := make([]int, 0, len(events))
    for k := range events {
        keys = append(keys, k)
    }
    sort.Ints(keys)

    res := make([][]int64, 0)
    prevPos := -1
    var currentColor int64
    for _, pos := range keys {
        if prevPos != -1 && currentColor != 0 {
            res = append(res, []int64{int64(prevPos), int64(pos), currentColor})
        }
        currentColor += events[pos]
        prevPos = pos
    }
    return res
}