type Graph struct {
    edges map[int][]int
}

func (g *Graph) addEdge(u, v int) {
    g.edges[u] = append(g.edges[u], v)
}

func findAncestors(n int, edges [][]int, node int) []int {
    g := Graph{edges: make(map[int][]int)}
    for _, edge := range edges {
        g.addEdge(edge[0], edge[1])
    }

    ancestors := make(map[int]struct{})
    var dfs func(int)
    dfs = func(current int) {
        for _, neighbor := range g.edges[current] {
            if _, found := ancestors[neighbor]; !found {
                ancestors[neighbor] = struct{}{}
                dfs(neighbor)
            }
        }
    }

    dfs(node)
    result := make([]int, 0, len(ancestors))
    for ancestor := range ancestors {
        result = append(result, ancestor)
    }
    sort.Ints(result)
    return result
}