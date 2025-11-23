func findMinHeightTrees(n int, edges [][]int) []int {
    if n == 1 {
        return []int{0}
    }

    adj := make([]map[int]bool, n)
    for i := 0; i < n; i++ {
        adj[i] = make(map[int]bool)
    }
    for _, e := range edges {
        adj[e[0]][e[1]] = true
        adj[e[1]][e[0]] = true
    }

    leaves := []int{}
    for i := 0; i < n; i++ {
        if len(adj[i]) == 1 {
            leaves = append(leaves, i)
        }
    }

    remainingNodes := n
    for remainingNodes > 2 {
        remainingNodes -= len(leaves)
        newLeaves := []int{}
        for _, leaf := range leaves {
            var neighbor int
            for n := range adj[leaf] {
                neighbor = n
                break
            }
            delete(adj[neighbor], leaf)
            if len(adj[neighbor]) == 1 {
                newLeaves = append(newLeaves, neighbor)
            }
        }
        leaves = newLeaves
    }

    return leaves
}