func maxSpending(values [][]int) int64 {
    m := len(values)
    n := len(values[0])

    pointers := make([]int, m)
    for i := range pointers {
        pointers[i] = n - 1
    }

    var total int64 = 0
    day := 1

    for {
        minVal := math.MaxInt32
        minIndex := -1

        for i := 0; i < m; i++ {
            if pointers[i] >= 0 {
                if values[i][pointers[i]] < minVal {
                    minVal = values[i][pointers[i]]
                    minIndex = i
                }
            }
        }

        if minIndex == -1 {
            break
        }

        total += int64(day * minVal)
        day++
        pointers[minIndex]--
    }

    return total
}