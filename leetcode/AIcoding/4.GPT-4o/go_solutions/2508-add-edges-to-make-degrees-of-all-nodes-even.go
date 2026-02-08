func addEdges(n int, edges [][]int) [][]int {
    degree := make([]int, n)
    for _, edge := range edges {
        degree[edge[0]]++
        degree[edge[1]]++
    }

    oddNodes := []int{}
    for i := 0; i < n; i++ {
        if degree[i]%2 != 0 {
            oddNodes = append(oddNodes, i)
        }
    }

    result := [][]int{}
    for i := 0; i < len(oddNodes); i += 2 {
        result = append(result, []int{oddNodes[i], oddNodes[i+1]})
    }

    return result
}