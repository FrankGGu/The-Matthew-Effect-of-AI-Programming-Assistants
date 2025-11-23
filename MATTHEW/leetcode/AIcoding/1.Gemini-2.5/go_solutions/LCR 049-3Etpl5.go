func sumNumbers(root *TreeNode) int {
    totalSum := 0

    var dfs func(*TreeNode, int)
    dfs = func(node *TreeNode, currentNum int) {
        if node == nil {
            return
        }

        currentNum = currentNum*10 + node.Val

        if node.Left == nil && node.Right == nil {
            totalSum += currentNum
            return
        }

        dfs(node.Left, currentNum)
        dfs(node.Right, currentNum)
    }

    dfs(root, 0)

    return totalSum
}