package main


func connectNodes(root *TreeNode, target int) int {
    var count int
    var dfs func(*TreeNode, int) bool
    dfs = func(node *TreeNode, depth int) bool {
        if node == nil {
            return false
        }
        if node.Val == target {
            count++
            return true
        }
        left := dfs(node.Left, depth+1)
        right := dfs(node.Right, depth+1)
        if left || right {
            count++
            return true
        }
        return false
    }
    dfs(root, 0)
    return count
}