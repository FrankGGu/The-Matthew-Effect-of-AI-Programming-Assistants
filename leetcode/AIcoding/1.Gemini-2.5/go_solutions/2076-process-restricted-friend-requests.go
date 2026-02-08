func find(parent []int, i int) int {
	if parent[i] == i {
		return i
	}
	parent[i] = find(parent, parent[i])
	return parent[i]
}

func union(parent []int, i, j int) {
	rootI := find