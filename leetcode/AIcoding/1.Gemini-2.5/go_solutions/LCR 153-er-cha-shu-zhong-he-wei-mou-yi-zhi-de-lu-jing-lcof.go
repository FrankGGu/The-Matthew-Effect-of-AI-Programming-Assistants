func pathSum(root *TreeNode, targetSum int) [][]int {
    result := [][]int{}
    currentPath := []int{}

    var dfs func(node *TreeNode, currentSum int)
    dfs = func(node *TreeNode, currentSum int) {
        if node == nil {
            return
        }

        currentPath = append(currentPath, node.Val)
        currentSum += node.Val

        if node.Left == nil && node.Right == nil {
            if currentSum == targetSum {
                tempPath := make([]int, len(currentPath))
                copy(tempPath, currentPath)
                result = append(result, tempPath)
            }
        }

        dfs(node.Left, currentSum)
        dfs(node.Right, currentSum)

        currentPath = currentPath[:len(currentPath)-1]
    }

    dfs(root, 0)
    return result
}