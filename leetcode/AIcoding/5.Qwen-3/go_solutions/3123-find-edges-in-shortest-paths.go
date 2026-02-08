package main

func findCriticalAndPseudoCriticalEdges(n int, edges [][]int) [][]int {
    type edge struct {
        u, v, weight, index int
    }
    edgesWithIndex := make([]edge, len(edges))
    for i, e := range edges {
        edgesWithIndex[i] = edge{e[0], e[1], e[2], i}
    }

    sort.Slice(edgesWithIndex, func(i, j int) bool {
        return edgesWithIndex[i].weight < edgesWithIndex[j].weight
    })

    mstWeight := func(excludeEdge int) int {
        parent := make([]int, n)
        for i := range parent {
            parent[i] = i
        }
        var find func(int) int
        find = func(x int) int {
            if parent[x] != x {
                parent[x] = find(parent[x])
            }
            return parent[x]
        }
        union := func(x, y int) bool {
            fx, fy := find(x), find(y)
            if fx == fy {
                return false
            }
            parent[fx] = fy
            return true
        }
        totalWeight := 0
        for i, e := range edgesWithIndex {
            if excludeEdge == e.index {
                continue
            }
            if union(e.u, e.v) {
                totalWeight += e.weight
            }
        }
        for i := 0; i < n; i++ {
            find(i)
        }
        for i := 1; i < n; i++ {
            if find(0) != find(i) {
                return -1
            }
        }
        return totalWeight
    }

    originalMSTWeight := mstWeight(-1)

    critical := make([]int, 0)
    pseudoCritical := make([]int, 0)

    for _, e := range edgesWithIndex {
        weightWithout := mstWeight(e.index)
        if weightWithout != originalMSTWeight {
            critical = append(critical, e.index)
        } else {
            weightWith := func() int {
                parent := make([]int, n)
                for i := range parent {
                    parent[i] = i
                }
                var find func(int) int
                find = func(x int) int {
                    if parent[x] != x {
                        parent[x] = find(parent[x])
                    }
                    return parent[x]
                }
                union := func(x, y int) bool {
                    fx, fy := find(x), find(y)
                    if fx == fy {
                        return false
                    }
                    parent[fx] = fy
                    return true
                }
                totalWeight := e.weight
                union(e.u, e.v)
                for _, edge := range edgesWithIndex {
                    if edge.index == e.index {
                        continue
                    }
                    if union(edge.u, edge.v) {
                        totalWeight += edge.weight
                    }
                }
                for i := 0; i < n; i++ {
                    find(i)
                }
                for i := 1; i < n; i++ {
                    if find(0) != find(i) {
                        return -1
                    }
                }
                return totalWeight
            }()
            if weightWith == originalMSTWeight {
                pseudoCritical = append(pseudoCritical, e.index)
            }
        }
    }

    sort.Ints(critical)
    sort.Ints(pseudoCritical)
    return [][]int{critical, pseudoCritical}
}