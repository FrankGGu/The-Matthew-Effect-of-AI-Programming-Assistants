func findChampion(n int, edges [][]int) int {
    inDegree := make([]int, n)

    for _, edge := range edges {
        // edge[0] defeated edge[1], so edge[1]'s in-degree increases
        inDegree[edge[1]]++
    }

    champion := -