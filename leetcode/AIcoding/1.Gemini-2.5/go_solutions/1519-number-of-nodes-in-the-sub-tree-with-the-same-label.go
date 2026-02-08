func countSubTrees(n int, edges [][]int, labels string) []int {
    adj := make([][]int, n)
    for _, edge := range edges {
        u, v := edge[0], edge[1]
        adj[u] = append(adj[u], v)
        adj[v] = append(adj[v], u)
    }

    ans := make([]int, n)

    var dfs func(node int, parent int) [26]int
    dfs = func(node int, parent int) [26]int {
        counts := [26]int{}

        for _, neighbor := range adj[node] {
            if neighbor == parent {
                continue
            }
            childCounts := dfs(neighbor, node)
            for i := 0; i < 26; i++ {
                counts[i] += childCounts[i]
            }
        }

        labelIndex := labels[node] - 'a'
        counts[labelIndex]++

        ans[node] = counts[labelIndex]

        return counts
    }

    dfs(0, -1)

    return ans
}