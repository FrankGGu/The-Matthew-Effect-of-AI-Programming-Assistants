import "sort"

func minimumRemoval(beans []int) int64 {
    sort.Ints(beans)
    total := int64(0)
    for _, num := range beans {
        total += int64(num)
    }
    minRemoval := total
    n := len(beans)
    for i := 0; i < n; i++ {
        current := total - int64(beans[i]) * int64(n - i)
        if current < minRemoval {
            minRemoval = current
        }
    }
    return minRemoval
}