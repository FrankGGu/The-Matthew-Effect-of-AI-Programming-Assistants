func countRootNodes(edges [][]int) int {
    indegree := make(map[int]int)
    for _, edge := range edges {
        indegree[edge[1]]++
    }
    count := 0
    for node := range indegree {
        if indegree[node] == 0 {
            count++
        }
    }
    return count + len(edges) + 1 - len(indegree)
}