import (
	"sort"
)

type UnionFind struct {
	parent []int
}

func NewUnionFind(size int) *UnionFind {
	parent := make([]int, size)
	for i := range parent {
		parent[i] = i
	}
	return &UnionFind{parent}
}

func (uf *UnionFind) Find(x int) int {
	if uf.parent[x] != x {
		uf.parent[x] = uf.Find(uf.parent[x])
	}
	return uf.parent[x]
}

func (uf *UnionFind) Union(x, y int) {
	rootX := uf.Find(x)
	rootY := uf.Find(y)
	if rootX != rootY {
		uf.parent[rootX] = rootY
	}
}

func matrixRankTransform(matrix [][]int) [][]int {
	m, n := len(matrix), len(matrix[0])
	rank := make([]int, m+n)
	valuePositions := make(map[int][][2]int)

	for i := 0; i < m; i++ {
		for j := 0; j < n; j++ {
			v := matrix[i][j]
			valuePositions[v] = append(valuePositions[v], [2]int{i, j})
		}
	}

	keys := make([]int, 0, len(valuePositions))
	for k := range valuePositions {
		keys = append(keys, k)
	}
	sort.Ints(keys)

	for _, v := range keys {
		positions := valuePositions[v]
		uf := NewUnionFind(m + n)
		rootMaxRank := make(map[int]int)

		for _, pos := range positions {
			i, j := pos[0], pos[1]
			uf.Union(i, j+m)
		}

		for _, pos := range positions {
			i, j := pos[0], pos[1]
			root := uf.Find(i)
			currentMax := max(rank[i], rank[j+m])
			if rootMaxRank[root] < currentMax {
				rootMaxRank[root] = currentMax
			}
		}

		for _, pos := range positions {
			i, j := pos[0], pos[1]
			root := uf.Find(i)
			newRank := rootMaxRank[root] + 1
			rank[i] = newRank
			rank[j+m] = newRank
			matrix[i][j] = newRank
		}
	}

	return matrix
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}