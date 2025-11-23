package main

func analyzeOrganizationHierarchy(employees [][]int) []int {
    children := make(map[int][]int)
    var maxID int
    var roots []int // Stores IDs of employees whose manager is -1

    // Build the adjacency list (children map) and identify root employees.
    // Also find the maximum employee ID to size the result array.
    for _, emp := range employees {
        employeeID := emp[0]
        managerID := emp[1]

        if employeeID > maxID {
            maxID = employeeID
        }

        if managerID != -1 {
            children[managerID] = append(children[managerID], employeeID)
        } else {
            // This employee is a root (CEO) as they have no manager within the system
            roots = append(roots, employeeID)
        }
    }

    // Initialize the result array. It's sized maxID + 1 to accommodate 1-indexed IDs
    // up to maxID. If employees is empty, maxID remains 0, resulting in ans = [0].
    ans := make([]int, maxID+1)

    // dfs is a recursive helper function to calculate the total number of
    // direct and indirect subordinates for a given employee 'u'.
    // It updates the 'ans' array with the calculated count for 'u' and returns it.
    var dfs func(u int) int
    dfs = func(u int) int {
        currentSubordinates := 0
        // Iterate through all direct subordinates of 'u'
        for _, v := range children[u] {
            // Each direct subordinate 'v' contributes itself (1)
            // plus all of its own subordinates (recursively calculated by dfs(v)).
            currentSubordinates += (1 + dfs(v))
        }
        // Store the calculated total subordinate count for employee 'u'.
        ans[u] = currentSubordinates
        return currentSubordinates // The return value is used by the parent call
    }

    // Start the DFS traversal from each identified root.
    // This ensures all parts of the hierarchy are processed, even if there are
    // multiple disconnected components (though typically an organization hierarchy
    // is a single connected tree).
    for _, root := range roots {
        dfs(root)
    }

    return ans
}