package main


func numColor(root *TreeNode) int {
    set := make(map[int]bool)
    dfs(root, set)
    return len(set)
}

func dfs(node *TreeNode, set map[int]bool) {
    if node == nil {
        return
    }
    set[node.Val] = true
    dfs(node.Left, set)
    dfs(node.Right, set)
}