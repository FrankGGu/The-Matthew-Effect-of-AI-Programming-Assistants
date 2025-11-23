func permutationQuery(n int, queries []int) []int {
    perm := make([]int, n)
    for i := 0; i < n; i++ {
        perm[i] = i + 1
    }

    results := make([]int, len(queries))
    for i, q := range queries {
        results[i] = perm[q-1]
        copy(perm[1:], perm[:q-1])
        perm[0] = results[i]
    }

    return results
}