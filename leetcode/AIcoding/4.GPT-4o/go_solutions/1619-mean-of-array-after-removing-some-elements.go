func trimMean(arr []int) float64 {
    n := len(arr)
    sort.Ints(arr)
    total := 0
    for i := n/20; i < n*19/20; i++ {
        total += arr[i]
    }
    return float64(total) / float64(n*18/20)
}