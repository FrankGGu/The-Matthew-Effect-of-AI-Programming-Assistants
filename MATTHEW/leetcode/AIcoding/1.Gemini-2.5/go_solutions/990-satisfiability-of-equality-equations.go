type unionFind struct {
	parent [26]int
}

func newUnionFind() *unionFind {
	uf := &unionFind{}
	for i := 0; i < 26; i++ {
		uf.parent[i] = i
	}
	return uf
}

func (uf *unionFind) find(i int) int {
	if uf.parent[i] == i {
		return i
	}
	uf.parent[i] = uf.find(uf.parent[i]) // Path compression
	return uf.parent[i]
}

func (uf *unionFind) union(i, j int) {
	rootI := uf.find(i)
	rootJ := uf.find(j)
	if rootI != rootJ {
		uf.parent[rootI] = rootJ // Simple union
	}
}

func equationsPossible(equations []string) bool {
	uf := newUnionFind()

	// Phase 1: Process all equality equations
	for _, eq := range equations {
		if eq[1] == '=' { // '=='
			char1 := int(eq[0] - 'a')
			char2 := int(eq[3] - 'a')
			uf.union(char1, char2)
		}
	}

	// Phase 2: Process all inequality equations
	for _, eq := range equations {