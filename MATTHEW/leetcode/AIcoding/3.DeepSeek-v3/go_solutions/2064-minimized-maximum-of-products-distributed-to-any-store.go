func minimizedMaximum(n int, quantities []int) int {
    left, right := 1, 0
    for _, q := range quantities {
        if q > right {
            right = q
        }
    }

    for left < right {
        mid := left + (right-left)/2
        total := 0
        for _, q := range quantities {
            total += (q + mid - 1) / mid
        }
        if total > n {
            left = mid + 1
        } else {
            right = mid
        }
    }
    return left
}