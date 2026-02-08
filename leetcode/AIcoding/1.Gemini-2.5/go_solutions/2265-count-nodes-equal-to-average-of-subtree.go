var totalCount int

func averageOfSubtree(root *TreeNode) int {
    totalCount = 0 // Reset for each test case
    dfs(root)
    return totalCount
}

func dfs(node *TreeNode) (int, int) {
    if node == nil {
        return 0, 0
    }

    leftSum, leftCount := dfs(node.Left)
    rightSum, rightCount := dfs(node.Right)

    currentSubtreeSum := node.Val + leftSum + rightSum
    currentSubtreeNodeCount := 1 + leftCount + rightCount

    // Calculate the average for the current subtree.
    // Integer division automatically handles rounding down as required.
    if node.Val == currentSubtreeSum / currentSubtreeNodeCount {
        totalCount++
    }

    return currentSubtreeSum, currentSubtreeNodeCount
}