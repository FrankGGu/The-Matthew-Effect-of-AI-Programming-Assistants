func findMinHeightTrees(n int, edges [][]int) []int {
    if n == 1 {
        return []int{0}
    }
    graph := make([][]int, n)
    degree := make([]int, n)
    for _, edge := range edges {
        graph[edge[0]] = append(graph[edge[0]], edge[1])
        graph[edge[1]] = append(graph[edge[1]], edge[0])
        degree[edge[0]]++
        degree[edge[1]]++
    }

    leaves := []int{}
    for i := 0; i < n; i++ {
        if degree[i] == 1 {
            leaves = append(leaves, i)
        }
    }

    remainingNodes := n
    for remainingNodes > 2 {
        remainingNodes -= len(leaves)
        newLeaves := []int{}
        for _, leaf := range leaves {
            for _, neighbor := range graph[leaf] {
                degree[neighbor]--
                if degree[neighbor] == 1 {
                    newLeaves = append(newLeaves, neighbor)
                }
            }
        }
        leaves = newLeaves
    }

    return leaves
}