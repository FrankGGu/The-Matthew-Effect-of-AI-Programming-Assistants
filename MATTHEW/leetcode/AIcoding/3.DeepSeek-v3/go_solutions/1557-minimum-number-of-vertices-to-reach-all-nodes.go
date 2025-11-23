func findSmallestSetOfVertices(n int, edges [][]int) []int {
    inDegree := make([]int, n)
    for _, edge := range edges {
        inDegree[edge[1]]++
    }
    result := []int{}
    for i := 0; i < n; i++ {
        if inDegree[i] == 0 {
            result = append(result, i)
        }
    }
    return result
}