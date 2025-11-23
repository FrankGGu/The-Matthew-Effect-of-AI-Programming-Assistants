func hIndex(citations []int) int {
    n := len(citations)
    sort.Ints(citations)

    for i := 0; i < n; i++ {
        h := n - i
        if citations[i] >= h {
            return h
        }
    }
    return 0
}