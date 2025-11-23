func buildArray(n int, m int, k int) []int {
    if k < n-1 || k > m {
        return []int{}
    }

    result := make([]int, n)
    for i := 0; i < n; i++ {
        result[i] = i + 1
    }

    if k == n-1 {
        return result
    }

    result[n-1] = m
    for i := n - 2; i >= 0 && k > n-1; i-- {
        result[i] = result[i+1] - 1
        k--
    }

    return result
}