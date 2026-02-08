package main


func longestZigZag(root *TreeNode) int {
    maxLen := 0
    var dfs func(*TreeNode, bool, int)
    dfs = func(node *TreeNode, isLeft bool, length int) {
        if node == nil {
            return
        }
        maxLen = max(maxLen, length)
        if isLeft {
            dfs(node.Right, false, length+1)
            dfs(node.Left, true, 1)
        } else {
            dfs(node.Left, true, length+1)
            dfs(node.Right, false, 1)
        }
    }
    dfs(root, true, 0)
    dfs(root, false, 0)
    return maxLen
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}