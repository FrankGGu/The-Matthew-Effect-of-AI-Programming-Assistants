func minCost(n int, edges [][]int, cost []int) int {
    adj := make([][]int, n)
    for i := range edges {
        u, v := edges[i][0], edges[i][1]
        adj[u] = append(adj[u], i)
        adj[v] = append(adj[v], i)
    }

    ans := -1
    for i := 0; i < n; i++ {
        for j := range adj[i] {
            edge1Idx := adj[i][j]
            u1, v1 := edges[edge1Idx][0], edges[edge1Idx][1]
            otherNode1 := v1
            if otherNode1 == i {
                otherNode1 = u1
            }

            for k := j + 1; k < len(adj[i]); k++ {
                edge2Idx := adj[i][k]
                u2, v2 := edges[edge2Idx][0], edges[edge2Idx][1]
                otherNode2 := v2
                if otherNode2 == i {
                    otherNode2 = u2
                }

                if otherNode1 == otherNode2 {
                    continue
                }

                max1 := cost[edge1Idx]
                max2 := cost[edge2Idx]

                for l := 0; l < n; l++ {
                    if l == i || l == otherNode1 || l == otherNode2 {
                        continue
                    }

                    found1 := false
                    for m := range adj[l] {
                        edgeIdx := adj[l][m]
                        u, v := edges[edgeIdx][0], edges[edgeIdx][1]
                        if (u == otherNode1 && v == l) || (v == otherNode1 && u == l) {
                            max1 = max(max1, cost[edgeIdx])
                            found1 = true
                            break
                        }
                    }
                    if !found1 {
                         for m := range adj[otherNode1] {
                            edgeIdx := adj[otherNode1][m]
                            u, v := edges[edgeIdx][0], edges[edgeIdx][1]
                            if (u == otherNode1 && v == l) || (v == otherNode1 && u == l) {
                                max1 = max(max1, cost[edgeIdx])
                                found1 = true
                                break
                            }
                         }
                    }

                    found2 := false
                    for m := range adj[l] {
                        edgeIdx := adj[l][m]
                        u, v := edges[edgeIdx][0], edges[edgeIdx][1]
                        if (u == otherNode2 && v == l) || (v == otherNode2 && u == l) {
                            max2 = max(max2, cost[edgeIdx])
                            found2 = true
                            break
                        }
                    }
                    if !found2 {
                        for m := range adj[otherNode2] {
                            edgeIdx := adj[otherNode2][m]
                            u, v := edges[edgeIdx][0], edges[edgeIdx][1]
                            if (u == otherNode2 && v == l) || (v == otherNode2 && u == l) {
                                max2 = max(max2, cost[edgeIdx])
                                found2 = true
                                break
                            }
                         }
                    }
                }

                cur := cost[edge1Idx] + cost[edge2Idx] + max1 + max2
                if ans == -1 || cur < ans {
                    ans = cur
                }
            }
        }
    }

    return ans
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}