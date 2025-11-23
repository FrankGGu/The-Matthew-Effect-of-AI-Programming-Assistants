package main

func guardRecall(soldierPositions []int, recallTime int) int {
    n := len(soldierPositions)
    if n == 0 {
        return 0
    }
    sort.Ints(soldierPositions)
    res := 0
    for i := 0; i < n; i++ {
        left := i
        right := n - 1
        for left <= right {
            mid := (left + right) / 2
            if soldierPositions[mid]-soldierPositions[i] <= recallTime {
                left = mid + 1
            } else {
                right = mid - 1
            }
        }
        res = max(res, left-i)
    }
    return res
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}