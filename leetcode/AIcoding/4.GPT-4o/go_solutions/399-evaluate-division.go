type UnionFind struct {
    parent map[string]string
    weight  map[string]float64
}

func (uf *UnionFind) find(x string) (string, float64) {
    if _, ok := uf.parent[x]; !ok {
        uf.parent[x] = x
        uf.weight[x] = 1.0
    }
    if uf.parent[x] != x {
        originParent := uf.parent[x]
        originWeight := uf.weight[x]
        parent, parentWeight := uf.find(originParent)
        uf.parent[x] = parent
        uf.weight[x] = originWeight * parentWeight
    }
    return uf.parent[x], uf.weight[x]
}

func (uf *UnionFind) union(x, y string, value float64) {
    rootX, weightX := uf.find(x)
    rootY, weightY := uf.find(y)
    if rootX != rootY {
        uf.parent[rootX] = rootY
        uf.weight[rootX] = weightY / weightX * value
    }
}

func calcEquation(equations [][]string, values []float64, queries [][]string) []float64 {
    uf := &UnionFind{
        parent: make(map[string]string),
        weight: make(map[string]float64),
    }

    for i, eq := range equations {
        uf.union(eq[0], eq[1], values[i])
    }

    result := make([]float64, len(queries))
    for i, query := range queries {
        rootA, weightA := uf.find(query[0])
        rootB, weightB := uf.find(query[1])
        if rootA != rootB {
            result[i] = -1.0
        } else {
            result[i] = weightA / weightB
        }
    }

    return result
}