package main


func goodNodes(root *TreeNode) int {
    var count int
    var dfs func(*TreeNode, int)
    dfs = func(node *TreeNode, maxSoFar int) {
        if node == nil {
            return
        }
        if node.Val >= maxSoFar {
            count++
        }
        if node.Left != nil {
            dfs(node.Left, max(node.Val, maxSoFar))
        }
        if node.Right != nil {
            dfs(node.Right, max(node.Val, maxSoFar))
        }
    }
    dfs(root, root.Val)
    return count
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}