func pathSum(root *TreeNode, targetSum int) int {
    count := 0
    prefixSumCount := make(map[int]int)
    prefixSumCount[0] = 1 // Base case: a path starting from the root with sum 0 is considered

    var dfs func(node *TreeNode, currentSum int)
    dfs = func(node *TreeNode, currentSum int) {
        if node == nil {
            return
        }

        currentSum += node.Val

        // Check if there's a prefix sum that makes the current path sum to targetSum
        // If currentSum - targetSum exists in prefixSumCount, it means there's a subpath
        // ending at the current node that sums to targetSum.
        if val, ok := prefixSumCount[currentSum - targetSum]; ok {
            count += val
        }

        // Add the current sum to the map for future calculations
        prefixSumCount[currentSum]++

        // Recurse on children
        dfs(node.Left, currentSum)
        dfs(node.Right, currentSum)

        // Backtrack: remove the current sum from the map
        // This is crucial because prefixSumCount should only reflect sums
        // along the current path from the root to the current node.
        prefixSumCount[currentSum]--
    }

    dfs(root, 0) // Start DFS from root with initial sum 0
    return count
}