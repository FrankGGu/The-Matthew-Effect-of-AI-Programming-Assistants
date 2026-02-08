func transportationHub(path [][]int) int {
    inDegree := make(map[int]int)
    outDegree := make(map[int]int)
    nodes := make(map[int]bool)

    for _, p := range path {
        outDegree[p[0]]++
        inDegree[p[1]]++
        nodes[p[0]] = true
        nodes[p[1]] = true
    }

    n := len(nodes)
    for node := range nodes {
        if inDegree[node] == n-1 && outDegree[node] == 0 {
            return node
        }
    }

    return -1
}