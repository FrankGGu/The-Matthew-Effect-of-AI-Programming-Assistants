func cycleLengthQueries(n int, queries [][]int) []int {
    parent := make([]int, n+1)
    for i := 2; i <= n; i++ {
        parent[i] = i / 2
    }

    results := make([]int, len(queries))
    for i, q := range queries {
        a, b := q[0], q[1]
        length := 0
        visited := make(map[int]bool)

        for a != 0 || b != 0 {
            if a == b {
                length += 1
                break
            }
            if a > b {
                if !visited[a] {
                    visited[a] = true
                    length += 1
                }
                a = parent[a]
            } else {
                if !visited[b] {
                    visited[b] = true
                    length += 1
                }
                b = parent[b]
            }
        }
        results[i] = length
    }
    return results
}