func sumRootToLeaf(root *TreeNode) int {
    totalSum := 0

    var dfs func(node *TreeNode, currentNumber int)
    dfs = func(node *TreeNode, currentNumber int) {
        if node == nil {
            return
        }

        currentNumber = (currentNumber << 1) | node.Val

        if node.Left == nil && node.Right == nil {
            totalSum += currentNumber
            return
        }

        dfs(node.Left, currentNumber)
        dfs(node.Right, currentNumber)
    }

    dfs(root, 0)
    return totalSum
}