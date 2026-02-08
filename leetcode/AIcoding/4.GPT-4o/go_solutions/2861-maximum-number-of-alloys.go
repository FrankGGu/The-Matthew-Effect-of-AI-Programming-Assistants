func maxAlloys(A []int, B []int, C []int) int {
    n := len(A)
    left, right := 0, 1_000_000_000

    for left < right {
        mid := (left + right + 1) / 2
        total := 0
        for i := 0; i < n; i++ {
            total += min(A[i]/mid, B[i]/mid, C[i]/mid)
        }
        if total >= mid {
            left = mid
        } else {
            right = mid - 1
        }
    }
    return left
}

func min(a, b, c int) int {
    if a < b {
        if a < c {
            return a
        }
        return c
    }
    if b < c {
        return b
    }
    return c
}