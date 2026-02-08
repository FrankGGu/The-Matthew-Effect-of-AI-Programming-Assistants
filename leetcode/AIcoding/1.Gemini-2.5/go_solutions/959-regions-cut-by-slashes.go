type DSU struct {
    parent []int
    regions int
}

func newDSU(nNodes int) *DSU {
    parent := make([]int, nNodes)
    for i := range parent {
        parent[i] = i
    }
    return &DSU{parent: parent, regions: 1