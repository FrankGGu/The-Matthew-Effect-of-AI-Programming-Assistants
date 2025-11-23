func isHub(n int, edges [][]int, hub int) bool {
    cnt := 0
    for _, edge := range edges {
        if edge[0] != hub && edge[1] == hub {
            cnt++
        }
    }
    return cnt == n - 1
}

func transportationHub(roads [][]int) int {
    n := 0
    inDegree := make(map[int]int)
    outDegree := make(map[int]int)
    nodes := make(map[int]bool)

    for _, road := range roads {
        outDegree[road[0]]++
        inDegree[road[1]]++
        nodes[road[0]] = true
        nodes[road[1]] = true
    }

    for node := range nodes {
        n = max(n, node)
    }
    n++

    candidate := -1
    for node := range nodes {
        if _, ok := outDegree[node]; !ok {
            if _, ok := inDegree[node]; ok && inDegree[node] > 0 {
                if candidate == -1 {
                    candidate = node
                } else {
                    return -1
                }
            }
        }
    }

    if candidate == -1 {
        return -1
    }

    if !isHub(n, roads, candidate) {
        return -1
    }

    return candidate
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}