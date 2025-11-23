func longestWPI(hours []int) int {
    res := 0
    sum := 0
    m := make(map[int]int)

    for i := 0; i < len(hours); i++ {
        if hours[i] > 8 {
            sum++
        } else {
            sum--
        }

        if sum > 0 {
            res = i + 1
        } else {
            if _, ok := m[sum - 1]; ok {
                res = max(res, i - m[sum - 1])
            }
            if _, ok := m[sum]; !ok {
                m[sum] = i
            }
        }
    }
    return res
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}