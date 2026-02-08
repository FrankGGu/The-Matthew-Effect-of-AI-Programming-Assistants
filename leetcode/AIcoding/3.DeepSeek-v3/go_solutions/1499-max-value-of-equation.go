func findMaxValueOfEquation(points [][]int, k int) int {
    maxVal := -1 << 31
    deque := make([][2]int, 0)

    for _, point := range points {
        x, y := point[0], point[1]

        for len(deque) > 0 && x - deque[0][0] > k {
            deque = deque[1:]
        }

        if len(deque) > 0 {
            current := deque[0][1] + y + x - deque[0][0]
            if current > maxVal {
                maxVal = current
            }
        }

        for len(deque) > 0 && y - x >= deque[len(deque)-1][1] - deque[len(deque)-1][0] {
            deque = deque[:len(deque)-1]
        }

        deque = append(deque, [2]int{x, y})
    }

    return maxVal
}