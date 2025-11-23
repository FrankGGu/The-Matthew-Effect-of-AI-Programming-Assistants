func sortItems(n int, m int, group []int, beforeItems [][]int) []int {
	for i := 0; i < n; i++ {
		if group[i] == -1 {
			group[i] = m
			m++
		}
	}

	groupGraph := make([][]int, m)
	itemGraph := make([][]int, n)
	groupInDegree := make([]int, m)
	itemInDegree := make([]int, n)

	for i := 0; i < n; i++ {
		for _, before := range beforeItems[i] {
			if group[i] != group[before] {
				groupGraph[group[before]] = append(groupGraph[group[before]], group[i])
				groupInDegree[group[i]]++
			}
			itemGraph[before] = append(itemGraph[before], i)
			itemInDegree[i]++
		}
	}

	groupOrder := topologicalSort(m, groupGraph, groupInDegree)
	if len(groupOrder) == 0 {
		return []int{}
	}

	itemOrder := topologicalSort(n, itemGraph, itemInDegree)
	if len(itemOrder) == 0 {
		return []int{}
	}

	groupToItems := make(map[int][]int)
	for item := range itemOrder {
		g := group[itemOrder[item]]
		groupToItems[g] = append(groupToItems[g], itemOrder[item])
	}

	result := []int{}
	for _, g := range groupOrder {
		if items, ok := groupToItems[g]; ok {
			result = append(result, items...)
		}
	}

	return result
}

func topologicalSort(n int, graph [][]int, inDegree []int) []int {
	queue := []int{}
	for i := 0; i < n; i++ {
		if inDegree[i] == 0 {
			queue = append(queue, i)
		}
	}

	result := []int{}
	for len(queue) > 0 {
		node := queue[0]
		queue = queue[1:]
		result = append(result, node)

		for _, neighbor := range graph[node] {
			inDegree[neighbor]--
			if inDegree[neighbor] == 0 {
				queue = append(queue, neighbor)
			}
		}
	}

	if len(result) == n {
		return result
	}
	return []int{}
}