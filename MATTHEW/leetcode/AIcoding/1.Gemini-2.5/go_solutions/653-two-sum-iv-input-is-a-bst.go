func findTarget(root *TreeNode, k int) bool {
    seen := make(map[int]bool)
    return dfs(root, k, seen)
}

func dfs(node *TreeNode, k int, seen map[int]bool) bool {
    if node == nil {
        return false
    }

    complement := k - node.Val
    if seen[complement] {
        return true
    }

    seen[node.Val] = true

    if dfs(node.Left, k, seen) {
        return true
    }

    return dfs(node.Right, k, seen)
}