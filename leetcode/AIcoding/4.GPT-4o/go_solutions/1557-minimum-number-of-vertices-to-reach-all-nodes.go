func findSmallestSetOfVertices(n int, edges [][]int) []int {
    indegree := make([]int, n)
    for _, edge := range edges {
        indegree[edge[1]]++
    }

    result := []int{}
    for i := 0; i < n; i++ {
        if indegree[i] == 0 {
            result = append(result, i)
        }
    }

    return result
}