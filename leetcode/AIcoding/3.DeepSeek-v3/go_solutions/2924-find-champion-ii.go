func findChampion(n int, edges [][]int) int {
    inDegree := make([]int, n)
    for _, edge := range edges {
        inDegree[edge[1]]++
    }

    champion := -1
    for i := 0; i < n; i++ {
        if inDegree[i] == 0 {
            if champion != -1 {
                return -1
            }
            champion = i
        }
    }
    return champion
}