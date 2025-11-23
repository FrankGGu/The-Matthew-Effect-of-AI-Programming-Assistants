type Graph struct {
    parent []int
    rank   []int
}

func NewGraph(n int) *Graph {
    parent := make([]int, n)
    rank := make([]int, n)
    for i := range parent {
        parent[i] = i
    }
    return &Graph{parent, rank}
}

func (g *Graph) Find(u int) int {
    if g.parent[u] != u {
        g.parent[u] = g.Find(g.parent[u])
    }
    return g.parent[u]
}

func (g *Graph) Union(u, v int) bool {
    uRoot := g.Find(u)
    vRoot := g.Find(v)
    if uRoot == vRoot {
        return false
    }
    if g.rank[uRoot] > g.rank[vRoot] {
        g.parent[vRoot] = uRoot
    } else if g.rank[uRoot] < g.rank[vRoot] {
        g.parent[uRoot] = vRoot
    } else {
        g.parent[vRoot] = uRoot
        g.rank[uRoot]++
    }
    return true
}

func minCostConnectPoints(points [][]int) int {
    n := len(points)
    edges := make([][3]int, 0, n*(n-1)/2)
    for i := 0; i < n; i++ {
        for j := i + 1; j < n; j++ {
            dist := abs(points[i][0]-points[j][0]) + abs(points[i][1]-points[j][1])
            edges = append(edges, [3]int{dist, i, j})
        }
    }
    sort.Slice(edges, func(i, j int) bool {
        return edges[i][0] < edges[j][0]
    })

    g := NewGraph(n)
    totalCost := 0
    edgesUsed := 0
    for _, edge := range edges {
        if edgesUsed == n-1 {
            break
        }
        dist, u, v := edge[0], edge[1], edge[2]
        if g.Union(u, v) {
            totalCost += dist
            edgesUsed++
        }
    }
    return totalCost
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}