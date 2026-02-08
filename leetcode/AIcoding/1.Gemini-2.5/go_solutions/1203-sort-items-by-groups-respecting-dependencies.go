package main

func topologicalSort(graph map[int][]int, indegree map[int]int, nodes []int) []int {
	q := []int{}
	for _, node := range nodes {
		if indegree[node] == 0 {
			q = append(q, node)
		}
	}

	result := []int{}
	for len(q) > 0 {
		node := q[0]
		q = q[1:]
		result = append(result, node)

		for _, neighbor := range graph[node] {
			indegree[neighbor]--
			if indegree[neighbor] == 0 {
				q = append(q, neighbor)
			}
		}
	}

	if len(result) == len(nodes) {
		return result
	}
	return []int{}
}

func sortItems(n int, m int, groups []int, beforeItems [][]int) []int {
	nextGroupID := m
	for i := 0; i < n; i++ {
		if groups[i] == -1 {
			groups[i] = nextGroupID
			nextGroupID++
		}
	}
	m = nextGroupID

	itemGraph := make(map[int][]int)
	itemIndegree := make(map[int]int)
	groupGraph := make(map[int][]int)
	groupIndegree := make(map[int]int)
	groupToItemsMap := make(map[int][]int)

	for i := 0; i < n; i++ {
		itemIndegree[i] = 0
	}
	for i := 0; i < m; i++ {
		groupIndegree[i] = 0
	}

	for i := 0; i < n; i++ {
		groupToItemsMap[groups[i]] = append(groupToItemsMap[groups[i]], i)
		for _, prev := range beforeItems[i] {
			itemGraph[prev] = append(itemGraph[prev], i)
			itemIndegree[i]++

			if groups[prev] != groups[i] {
				groupGraph[groups[prev]] = append(groupGraph[groups[prev]], groups[i])
				groupIndegree[groups[i]]++
			}
		}
	}

	allGroupIDs := make([]int, m)
	for i := 0; i < m; i++ {
		allGroupIDs[i] = i
	}

	groupIndegreeCopy := make(map[int]int)
	for k, v := range groupIndegree {
		groupIndegreeCopy[k] = v
	}
	sortedGroups := topologicalSort(groupGraph, groupIndegreeCopy, allGroupIDs)
	if len(sortedGroups) == 0 {
		return []int{}
	}

	ans := []int{}
	for _, gID := range sortedGroups {
		itemsInCurrentGroup := groupToItemsMap[gID]

		localItemGraph := make(map[int][]int)
		localItemIndegree := make(map[int]int)

		for _, item := range itemsInCurrentGroup {
			localItemIndegree[item] = 0
		}

		for _, item := range itemsInCurrentGroup {
			for _, neighbor := range itemGraph[item] {
				if groups[neighbor] == gID {
					localItemGraph[item] = append(localItemGraph[item], neighbor)
					localItemIndegree[neighbor]++
				}
			}
		}

		sortedItems := topologicalSort(localItemGraph, localItemIndegree, itemsInCurrentGroup)
		if len(sortedItems) == 0 {
			return []int{}
		}
		ans = append(ans, sortedItems...)
	}

	return ans
}