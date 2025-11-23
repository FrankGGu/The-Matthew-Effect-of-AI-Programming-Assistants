import "math"

func updateMatrix(mat [][]int) [][]int {
	m := len(mat)
	n := len(mat[0])

	dist := make([][]int, m)
	for i := range dist {
		dist[i] = make([]int, n)
	}

	queue :=