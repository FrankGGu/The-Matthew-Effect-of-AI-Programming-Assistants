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

func (g *Graph) Union(u, v int) {
    uRoot := g.Find(u)
    vRoot := g.Find(v)
    if uRoot == vRoot {
        return
    }
    if g.rank[uRoot] > g.rank[vRoot] {
        g.parent[vRoot] = uRoot
    } else if g.rank[uRoot] < g.rank[vRoot] {
        g.parent[uRoot] = vRoot
    } else {
        g.parent[vRoot] = uRoot
        g.rank[uRoot]++
    }
}

type DistanceLimitedPathsExist struct {
    snapshots []*Graph
    times     []int
}

func Constructor(n int, edgeList [][]int) DistanceLimitedPathsExist {
    sort.Slice(edgeList, func(i, j int) bool {
        return edgeList[i][2] < edgeList[j][2]
    })

    snapshots := make([]*Graph, 0)
    times := make([]int, 0)

    g := NewGraph(n)
    prevTime := -1

    for _, edge := range edgeList {
        u, v, time := edge[0], edge[1], edge[2]
        if time == prevTime {
            g.Union(u, v)
            continue
        }
        snapshots = append(snapshots, &Graph{
            parent: append([]int(nil), g.parent...),
            rank:   append([]int(nil), g.rank...),
        })
        times = append(times, time)
        prevTime = time
        g.Union(u, v)
    }

    return DistanceLimitedPathsExist{snapshots, times}
}

func (this *DistanceLimitedPathsExist) Query(p int, q int, limit int) bool {
    idx := sort.Search(len(this.times), func(i int) bool {
        return this.times[i] >= limit
    }) - 1

    if idx == -1 {
        return p == q
    }

    snapshot := this.snapshots[idx]
    return snapshot.Find(p) == snapshot.Find(q)
}