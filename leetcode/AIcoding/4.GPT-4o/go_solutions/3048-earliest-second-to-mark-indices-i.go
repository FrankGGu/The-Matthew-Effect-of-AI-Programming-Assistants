func earliestFullMark(times []int) int {
    n := len(times)
    if n == 0 {
        return -1
    }

    marks := make(map[int]bool)
    for i := 0; i < n; i++ {
        marks[times[i]] = true
    }

    for i := 0; i <= 100; i++ {
        if !marks[i] {
            return i
        }
    }

    return -1
}