package main

func findPort(pairs [][]int) int {
    inDegree := make(map[int]int)
    outDegree := make(map[int]int)

    for _, pair := range pairs {
        u, v := pair[0], pair[1]
        outDegree[u]++
        inDegree[v]++
    }

    for node := range inDegree {
        if outDegree[node] == 0 {
            return node
        }
    }

    for node := range outDegree {
        if inDegree[node] == 0 {
            return node
        }
    }

    return -1
}