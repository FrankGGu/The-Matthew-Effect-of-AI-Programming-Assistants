func findTarget(root *TreeNode, k int) bool {
    seen := make(map[int]struct{})
    return dfs(root, k, seen)
}

func dfs(node *TreeNode, k int, seen map[int]struct{}) bool {
    if node == nil {
        return false
    }

    complement := k - node.Val
    if _, exists := seen[complement]; exists {
        return true
    }

    seen[node.Val] = struct{}{}

    if dfs(node.Left, k, seen) {
        return true
    }
    if dfs(node.Right, k, seen) {
        return true
    }

    return false
}