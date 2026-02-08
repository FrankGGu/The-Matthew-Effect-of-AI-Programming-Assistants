func leastBricks(wall [][]int) int {
    edgeCount := make(map[int]int)
    maxEdges := 0

    for _, row := range wall {
        edge := 0
        for i := 0; i < len(row)-1; i++ {
            edge += row[i]
            edgeCount[edge]++
            if edgeCount[edge] > maxEdges {
                maxEdges = edgeCount[edge]
            }
        }
    }

    return len(wall) - maxEdges
}