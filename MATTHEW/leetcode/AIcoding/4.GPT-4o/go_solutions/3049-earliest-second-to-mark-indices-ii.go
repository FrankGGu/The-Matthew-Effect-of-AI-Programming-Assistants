func earliestFullMark(indices []int, n int) int {
    mark := make([]bool, n)
    time := 0
    for time < len(indices) {
        if !mark[indices[time]] {
            mark[indices[time]] = true
            if allMarked(mark) {
                return time + 1
            }
        }
        time++
    }
    return -1
}

func allMarked(mark []bool) bool {
    for _, v := range mark {
        if !v {
            return false
        }
    }
    return true
}