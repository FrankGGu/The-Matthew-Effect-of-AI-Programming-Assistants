func timeTaken(start []int, end []int) []int {
    n := len(start)
    res := make([]int, n)
    currentTime := 1
    marked := make(map[int]bool)

    for i := 0; i < n; i++ {
        if marked[start[i]] {
            res[i] = currentTime
            currentTime++
            marked[end[i]] = true
        } else {
            marked[start[i]] = true
            res[i] = currentTime
            currentTime++
            marked[end[i]] = true
        }
    }

    return res
}