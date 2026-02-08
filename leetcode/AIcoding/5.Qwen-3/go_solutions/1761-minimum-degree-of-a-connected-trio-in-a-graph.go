package main

func minTrio(n int, edges [][]int) int {
    adj := make([][]bool, n)
    for i := range adj {
        adj[i] = make([]bool, n)
    }
    for _, edge := range edges {
        u, v := edge[0]-1, edge[1]-1
        adj[u][v] = true
        adj[v][u] = true
    }

    minDegree := n + 1

    for i := 0; i < n; i++ {
        for j := i + 1; j < n; j++ {
            if adj[i][j] {
                for k := j + 1; k < n; k++ {
                    if adj[i][k] && adj[j][k] {
                        degree := 0
                        for l := 0; l < n; l++ {
                            if adj[i][l] {
                                degree++
                            }
                            if adj[j][l] {
                                degree++
                            }
                            if adj[k][l] {
                                degree++
                            }
                        }
                        minDegree = min(minDegree, degree - 3)
                    }
                }
            }
        }
    }

    if minDegree == n+1 {
        return -1
    }
    return minDegree
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}