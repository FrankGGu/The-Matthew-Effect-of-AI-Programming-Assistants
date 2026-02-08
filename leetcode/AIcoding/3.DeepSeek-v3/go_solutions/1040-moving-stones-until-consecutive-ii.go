func numMovesStonesII(stones []int) []int {
    sort.Ints(stones)
    n := len(stones)
    maxMoves := max(stones[n-1]-stones[1]-n+2, stones[n-2]-stones[0]-n+2)
    minMoves := n
    j := 0
    for i := 0; i < n; i++ {
        for j+1 < n && stones[j+1]-stones[i] < n {
            j++
        }
        cost := n - (j - i + 1)
        if j-i+1 == n-1 && stones[j]-stones[i]+1 == n-1 {
            cost = 2
        }
        if cost < minMoves {
            minMoves = cost
        }
    }
    return []int{minMoves, maxMoves}
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}