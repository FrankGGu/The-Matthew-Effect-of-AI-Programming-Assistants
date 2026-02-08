func sequenceReconstruction(org []int, seqs [][]int) bool {
	n := len(org)
	graph := make([][]int, n+1)
	inDegree := make([]int, n+1)
	nums := make(map[int]bool)
	for _, seq := range seqs {
		for _, num := range seq {
			if num <= 0 || num > n {
				return false
			}
			nums[num] = true
		}
	}

	if len(nums) != n {
		return false
	}

	for _, seq := range seqs {
		for i := 0; i < len(seq)-1; i++ {
			u := seq[i]
			v := seq[i+1]
			graph[u] = append(graph[u], v)
			inDegree[v]++
		}
	}

	queue := []int{}
	for i := 1; i <= n; i++ {
		if inDegree[i] == 0 {
			queue = append(queue, i)
		}
	}

	idx := 0
	for len(queue) > 0 {
		if len(queue) > 1 {
			return false
		}
		u := queue[0]
		queue = queue[1:]

		if org[idx] != u {
			return false
		}
		idx++

		for _, v := range graph[u] {
			inDegree[v]--
			if inDegree[v] == 0 {
				queue = append(queue, v)
			}
		}
	}

	return idx == n
}