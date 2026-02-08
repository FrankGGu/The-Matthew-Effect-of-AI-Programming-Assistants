func platesBetweenCandles(s string, queries [][]int) []int {
    n := len(s)
    left := make([]int, n)
    right := make([]int, n)
    candleCount := 0
    prefixSum := 0

    for i := 0; i < n; i++ {
        if s[i] == '|' {
            candleCount++
            prefixSum = 0
        } else {
            prefixSum++
        }
        left[i] = candleCount
        if candleCount > 0 {
            right[i] = prefixSum
        }
    }

    candleCount = 0
    prefixSum = 0
    for i := n - 1; i >= 0; i-- {
        if s[i] == '|' {
            candleCount++
            prefixSum = 0
        } else {
            prefixSum++
        }
        right[i] += candleCount
    }

    result := make([]int, len(queries))
    for i, query := range queries {
        leftIdx, rightIdx := query[0], query[1]
        leftCandle := -1
        rightCandle := -1

        for j := leftIdx; j <= rightIdx; j++ {
            if s[j] == '|' {
                leftCandle = j
                break
            }
        }
        for j := rightIdx; j >= leftIdx; j-- {
            if s[j] == '|' {
                rightCandle = j
                break
            }
        }

        if leftCandle == -1 || rightCandle == -1 || leftCandle >= rightCandle {
            result[i] = 0
        } else {
            result[i] = rightCandle - leftCandle - (rightCandle - leftCandle + 1 - (rightIdx - leftIdx + 1))
        }
    }
    return result
}