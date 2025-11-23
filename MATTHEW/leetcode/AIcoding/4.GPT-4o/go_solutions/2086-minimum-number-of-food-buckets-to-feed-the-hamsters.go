func minNumberOfBuckets(food []int) int {
    n := len(food)
    if n == 0 {
        return 0
    }

    buckets := 0
    i := 0

    for i < n {
        if food[i] > 0 {
            buckets++
            if i + 1 < n {
                food[i+1] = max(0, food[i+1] - 1)
            }
            if i + 2 < n {
                food[i+2] = max(0, food[i+2] - 1)
            }
        }
        i++
    }

    return buckets
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}