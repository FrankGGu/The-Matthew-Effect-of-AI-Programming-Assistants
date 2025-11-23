func sumNumbers(root *TreeNode) int {
    return dfs(root, 0)
}

func dfs(node *TreeNode, currentNumber int) int {
    if node == nil {
        return 0
    }

    currentNumber = currentNumber*10 + node.Val

    if node.Left == nil && node.Right == nil {
        return currentNumber
    }

    leftSum := dfs(node.Left, currentNumber)
    rightSum := dfs(node.Right, currentNumber)

    return leftSum + rightSum
}