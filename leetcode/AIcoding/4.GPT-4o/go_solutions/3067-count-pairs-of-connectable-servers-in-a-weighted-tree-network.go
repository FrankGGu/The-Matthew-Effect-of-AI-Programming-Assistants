func countPairs(n int, edges [][]int, distance int) int64 {
    graph := make([][]int, n)
    for _, edge := range edges {
        graph[edge[0]] = append(graph[edge[0]], edge[1])
        graph[edge[1]] = append(graph[edge[1]], edge[0])
    }

    var dfs func(node, parent int, dist int) []int
    dfs = func(node, parent int, dist int) []int {
        count := make([]int, distance+1)
        count[0] = 1

        for _, neighbor := range graph[node] {
            if neighbor == parent {
                continue
            }
            subCount := dfs(neighbor, node, dist+1)
            for d := 0; d < distance; d++ {
                if d+1 < len(count) && d+1 < len(subCount) {
                    count[d+1] += subCount[d]
                }
            }
        }

        return count
    }

    totalPairs := int64(0)

    var countPairsFromNode func(node, parent int) []int
    countPairsFromNode = func(node, parent int) []int {
        count := dfs(node, parent, 0)
        pairs := int64(0)

        for d := 1; d < distance; d++ {
            pairs += int64(count[d]) * int64(count[distance-d])
        }

        for _, neighbor := range graph[node] {
            if neighbor == parent {
                continue
            }
            subCounts := countPairsFromNode(neighbor, node)
            for d := 0; d < distance; d++ {
                if d+1 < len(count) && d+1 < len(subCounts) {
                    count[d+1] += subCounts[d]
                }
            }
        }

        totalPairs += pairs
        return count
    }

    countPairsFromNode(0, -1)
    return totalPairs
}