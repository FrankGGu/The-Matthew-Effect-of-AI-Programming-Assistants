func maximumInvitations(favorite []int) int {
	n := len(favorite)
	inDegree := make([]int, n)
	depth := make([]int, n)
	visited := make([]bool, n)

	for i := 0; i < n; i++ {
		inDegree[favorite[i]]++
		depth[i] = 1
	}

	q := []int{}
	for i := 0; i < n; i++ {
		if inDegree[i] == 0 {
			q = append(q, i)
		}
	}

	head := 0
	for head < len(q) {
		u := q[head]
		head++
		v := favorite[u]
		depth[v] = max(depth[v], depth[u]+1)
		inDegree[v]--
		if inDegree[v] == 0 {
			q = append(q, v)
		}
	}

	sumLenGt2Cycles := 0
	sumLenLe2CyclesWithChains := 0

	for i := 0; i < n; i++ {
		if inDegree[i] > 0 && !visited[i] {
			curr := i
			cycleNodes := []int{}
			pathMap := make(map[int]int) // Node -> 1-based index in cycleNodes

			k := 0
			for {
				if pathMap[curr] != 0 {
					cycleStartIndex := pathMap[curr] - 1
					cycleLength := k - cycleStartIndex

					if cycleLength <= 2 {
						for idx := cycleStartIndex; idx < k; idx++ {
							node := cycleNodes[idx]
							sumLenLe2CyclesWithChains += depth[node]
						}
					} else {
						sumLenGt2Cycles += cycleLength
					}

					for idx := cycleStartIndex; idx < k; idx++ {
						visited[cycleNodes[idx]] = true
					}
					break
				}
				pathMap[curr] = k + 1
				cycleNodes = append(cycleNodes, curr)
				curr = favorite[curr]
				k++
			}
		}
	}

	return sumLenGt2Cycles + sumLenLe2CyclesWithChains
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}