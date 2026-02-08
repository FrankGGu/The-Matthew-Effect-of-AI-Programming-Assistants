func minFlips(mat [][]int) int {
	m, n := len(mat), len(mat[0])
	start := 0
	for i := 0; i < m; i++ {
		for j := 0; j < n; j++ {
			start = (start << 1) | mat[i][j]
		}
	}

	q := []int{start}
	visited := map[int]bool{start: true}
	steps := 0

	for len(q) > 0 {
		size := len(q)
		for i := 0; i < size; i++ {
			curr := q[i]
			if curr == 0 {
				return steps
			}

			for r := 0; r < m; r++ {
				for c := 0; c < n; c++ {
					next := curr
					next ^= (1 << (r*n + c))
					if r > 0 {
						next ^= (1 << ((r-1)*n + c))
					}
					if r < m-1 {
						next ^= (1 << ((r+1)*n + c))
					}
					if c > 0 {
						next ^= (1 << (r*n + (c-1)))
					}
					if c < n-1 {
						next ^= (1 << (r*n + (c+1)))
					}

					if !visited[next] {
						visited[next] = true
						q = append(q, next)
					}
				}
			}
		}
		q = q[size:]
		steps++
	}

	return -1
}