func sortItems(n int, m int, group []int, beforeItems [][]int) []int {
    groupID := m
    for i := 0; i < n; i++ {
        if group[i] == -1 {
            group[i] = groupID
            groupID++
        }
    }

    itemInDegree := make([]int, n)
    groupInDegree := make([]int, groupID)
    itemGraph := make([][]int, n)
    groupGraph := make([][]int, groupID)

    for i := 0; i < n; i++ {
        for _, prev := range beforeItems[i] {
            itemGraph[prev] = append(itemGraph[prev], i)
            itemInDegree[i]++
            if group[prev] != group[i] {
                groupGraph[group[prev]] = append(groupGraph[group[prev]], group[i])
                groupInDegree[group[i]]++
            }
        }
    }

    itemOrder := topologicalSort(itemGraph, itemInDegree)
    groupOrder := topologicalSort(groupGraph, groupInDegree)

    if len(itemOrder) != n || len(groupOrder) != groupID {
        return []int{}
    }

    groupToItems := make(map[int][]int)
    for _, item := range itemOrder {
        groupToItems[group[item]] = append(groupToItems[group[item]], item)
    }

    result := make([]int, 0, n)
    for _, groupID := range groupOrder {
        result = append(result, groupToItems[groupID]...)
    }

    return result
}

func topologicalSort(graph [][]int, inDegree []int) []int {
    queue := make([]int, 0)
    for i := 0; i < len(inDegree); i++ {
        if inDegree[i] == 0 {
            queue = append(queue, i)
        }
    }

    order := make([]int, 0)
    for len(queue) > 0 {
        u := queue[0]
        queue = queue[1:]
        order = append(order, u)
        for _, v := range graph[u] {
            inDegree[v]--
            if inDegree[v] == 0 {
                queue = append(queue, v)
            }
        }
    }

    return order
}