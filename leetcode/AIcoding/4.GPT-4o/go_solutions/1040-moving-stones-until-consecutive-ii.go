func numMovesStonesII(stones []int) []int {
    sort.Ints(stones)
    n := len(stones)
    maxMove := max(stones[n-1]-stones[0]-n+1, stones[n-2]-stones[0], stones[n-1]-stones[1])
    minMove := n

    for i := 0; i < n; i++ {
        if stones[i] < stones[0]+n {
            minMove = min(minMove, max(0, 2-i) + max(0, i-n+1))
        }
    }

    if minMove == n {
        minMove = 0
    }

    return []int{minMove, maxMove}
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}