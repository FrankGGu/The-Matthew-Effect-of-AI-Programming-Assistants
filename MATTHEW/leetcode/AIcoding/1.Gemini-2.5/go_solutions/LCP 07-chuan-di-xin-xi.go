func numWays(n int, relation [][]int, k int) int {
    adj := make([][]int, n)
    for _, r := range relation {
        src, dst := r[0], r[1]
        adj[src] = append(adj[src], dst)
    }

    dp :=