func minReverseOperations(n int, p int, banned []int, k int) []int {
    bannedSet := make(map[int]bool)
    for _, num := range banned {
        bannedSet[num] = true
    }

    res := make([]int, n)
    for i := range res {
        res[i] = -1
    }
    res[p] = 0

    queue := []int{p}
    for len(queue) > 0 {
        u := queue[0]
        queue = queue[1:]

        left := max(u - k + 1, 0)
        right := min(u, n - k)

        for start := left; start <= right; start++ {
            end := start + k - 1
            v := start + end - u
            if !bannedSet[v] && res[v] == -1 {
                res[v] = res[u] + 1
                queue = append(queue, v)
            }
        }
    }

    return res
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}