func analyzeHierarchy(employees [][]int) []int {
    managerMap := make(map[int][]int)
    for _, emp := range employees {
        id, managerID := emp[0], emp[1]
        if managerID != -1 {
            managerMap[managerID] = append(managerMap[managerID], id)
        }
    }

    maxDepth := 0
    maxSubordinates := 0
    maxSubordinatesID := -1

    for _, emp := range employees {
        id := emp[0]
        depth := getDepth(id, managerMap)
        if depth > maxDepth {
            maxDepth = depth
        }

        subordinates := len(managerMap[id])
        if subordinates > maxSubordinates || (subordinates == maxSubordinates && id < maxSubordinatesID) {
            maxSubordinates = subordinates
            maxSubordinatesID = id
        }
    }

    return []int{maxDepth, maxSubordinatesID}
}

func getDepth(id int, managerMap map[int][]int) int {
    maxDepth := 0
    for _, subordinate := range managerMap[id] {
        depth := getDepth(subordinate, managerMap)
        if depth > maxDepth {
            maxDepth = depth
        }
    }
    return maxDepth + 1
}