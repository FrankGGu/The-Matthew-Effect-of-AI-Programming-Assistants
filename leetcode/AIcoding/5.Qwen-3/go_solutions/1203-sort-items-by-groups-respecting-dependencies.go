package main

func sortItems(n int, m int, group []int, beforeItems [][]int) []int {
    // Build graph for groups and items
    groupGraph := make(map[int][]int)
    itemGraph := make(map[int][]int)
    groupInDegree := make(map[int]int)
    itemInDegree := make(map[int]int)

    // Initialize group and item in-degree
    for i := 0; i < n; i++ {
        if group[i] == -1 {
            continue
        }
        groupInDegree[group[i]] = 0
    }
    for i := 0; i < n; i++ {
        itemInDegree[i] = 0
    }

    // Assign unique group to items not in any group
    for i := 0; i < n; i++ {
        if group[i] == -1 {
            group[i] = m
            m++
        }
    }

    // Build graphs and in-degrees
    for i := 0; i < n; i++ {
        for _, prev := range beforeItems[i] {
            // Add edge from prev to i (item dependency)
            itemGraph[prev] = append(itemGraph[prev], i)
            itemInDegree[i]++

            // Add edge from group of prev to group of i (group dependency)
            if group[prev] != group[i] {
                groupGraph[group[prev]] = append(groupGraph[group[prev]], group[i])
                groupInDegree[group[i]]++
            }
        }
    }

    // Topological sort for groups
    groupQueue := []int{}
    for g := range groupInDegree {
        if groupInDegree[g] == 0 {
            groupQueue = append(groupQueue, g)
        }
    }

    groupOrder := []int{}
    for len(groupQueue) > 0 {
        current := groupQueue[0]
        groupOrder = append(groupOrder, current)
        groupQueue = groupQueue[1:]

        for _, neighbor := range groupGraph[current] {
            groupInDegree[neighbor]--
            if groupInDegree[neighbor] == 0 {
                groupQueue = append(groupQueue, neighbor)
            }
        }
    }

    if len(groupOrder) != m {
        return []int{}
    }

    // Topological sort for items within each group
    itemOrder := []int{}
    itemVisited := make(map[int]bool)
    for _, g := range groupOrder {
        // Collect all items in this group
        itemsInGroup := []int{}
        for i := 0; i < n; i++ {
            if group[i] == g {
                itemsInGroup = append(itemsInGroup, i)
            }
        }

        // Perform topological sort on items in this group
        itemQueue := []int{}
        for _, i := range itemsInGroup {
            if itemInDegree[i] == 0 {
                itemQueue = append(itemQueue, i)
            }
        }

        currentGroupOrder := []int{}
        for len(itemQueue) > 0 {
            current := itemQueue[0]
            currentGroupOrder = append(currentGroupOrder, current)
            itemQueue = itemQueue[1:]

            for _, neighbor := range itemGraph[current] {
                itemInDegree[neighbor]--
                if itemInDegree[neighbor] == 0 {
                    itemQueue = append(itemQueue, neighbor)
                }
            }
        }

        if len(currentGroupOrder) != len(itemsInGroup) {
            return []int{}
        }

        itemOrder = append(itemOrder, currentGroupOrder...)
    }

    return itemOrder
}