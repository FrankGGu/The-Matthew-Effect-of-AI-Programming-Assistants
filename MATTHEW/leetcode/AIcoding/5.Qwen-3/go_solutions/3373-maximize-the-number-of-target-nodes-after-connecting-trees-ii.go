package main


func connectNodes(root *TreeNode, x int, y int) int {
    var count int
    var dfs func(node *TreeNode, depth int, parent *TreeNode) int
    dfs = func(node *TreeNode, depth int, parent *TreeNode) int {
        if node == nil {
            return 0
        }
        left := dfs(node.Left, depth+1, node)
        right := dfs(node.Right, depth+1, node)
        if (depth == x && parent != nil) || (depth == y && parent != nil) {
            count++
        }
        return left + right + 1
    }
    dfs(root, 0, nil)
    return count
}