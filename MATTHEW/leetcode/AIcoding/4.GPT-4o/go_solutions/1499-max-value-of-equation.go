func findMaxValueOfEquation(points [][]int, k int) int {
    n := len(points)
    maxVal := math.MinInt32
    deque := []int{}

    for i := 0; i < n; i++ {
        for len(deque) > 0 && points[i][0]-points[deque[0]][0] > k {
            deque = deque[1:]
        }
        if len(deque) > 0 {
            maxVal = max(maxVal, points[i][0]+points[i][1]+points[deque[0]][1]-points[deque[0]][0])
        }
        for len(deque) > 0 && points[deque[len(deque)-1]][1]-points[deque[len(deque)-1]][0] < points[i][1]-points[i][0] {
            deque = deque[:len(deque)-1]
        }
        deque = append(deque, i)
    }
    return maxVal
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}