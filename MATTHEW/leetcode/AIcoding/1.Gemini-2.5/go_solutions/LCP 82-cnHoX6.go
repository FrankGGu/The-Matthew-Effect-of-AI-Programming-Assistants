func sumNumbers(root *TreeNode) int {
    totalSum := 0
    dfs(root, 0, &totalSum)
    return totalSum
}

func dfs(node *TreeNode, currentNum int, totalSum *int) {
    if node == nil {
        return
    }

    currentNum = currentNum*10 + node.Val

    if node.Left == nil && node.Right == nil {
        *totalSum += currentNum
        return
    }

    dfs(node.Left, currentNum, totalSum)
    dfs(node.Right, currentNum, totalSum)
}

type TreeNode struct {
    Val int
    Left *TreeNode
    Right *TreeNode
}