func countSubTrees(n int, edges [][]int, labels string) []int {
    adj := make([][]int, n)
    for _, e := range edges {
        u, v := e[0], e[1]
        adj[u] = append(adj[u], v)
        adj[v] = append(adj[v], u)
    }

    res := make([]int, n)
    dfs(0, -1, adj, labels, &res)
    return res
}

func dfs(node, parent int, adj [][]int, labels string, res *[]int) [26]int {
    count := [26]int{}
    count[labels[node]-'a']++

    for _, child := range adj[node] {
        if child == parent {
            continue
        }
        childCount := dfs(child, node, adj, labels, res)
        for i := 0; i < 26; i++ {
            count[i] += childCount[i]
        }
    }

    (*res)[node] = count[labels[node]-'a']
    return count
}