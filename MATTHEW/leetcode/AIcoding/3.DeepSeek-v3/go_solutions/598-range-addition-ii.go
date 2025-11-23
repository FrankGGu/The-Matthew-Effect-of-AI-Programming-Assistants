func maxCount(m int, n int, ops [][]int) int {
    minA, minB := m, n
    for _, op := range ops {
        if op[0] < minA {
            minA = op[0]
        }
        if op[1] < minB {
            minB = op[1]
        }
    }
    return minA * minB
}