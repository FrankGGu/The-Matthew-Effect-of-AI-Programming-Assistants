func minimumRemoval(beans []int) int64 {
    sort.Ints(beans)
    n := len(beans)
    total := int64(0)
    for _, b := range beans {
        total += int64(b)
    }

    minRemoval := int64(math.MaxInt64)
    for i := 0; i < n; i++ {
        removal := total - int64(beans[i]) * int64(n-i)
        if removal < minRemoval {
            minRemoval = removal
        }
    }

    return minRemoval
}