func hIndex(citations []int) int {
    n := len(citations)
    count := make([]int, n+1)

    for _, citation := range citations {
        if citation > n {
            count[n]++
        } else {
            count[citation]++
        }
    }

    total := 0
    for i := n; i >= 0; i-- {
        total += count[i]
        if total >= i {
            return i
        }
    }

    return 0
}