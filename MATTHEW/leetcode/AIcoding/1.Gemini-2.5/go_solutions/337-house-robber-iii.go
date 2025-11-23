func rob(root *TreeNode) int {
    res := dfs(root)
    return max(res[0], res[1])
}

func dfs(node *TreeNode) [2]int {
    if node == nil {
        return [2]int{0, 0}
    }

    leftRes := dfs(node.Left)
    rightRes := dfs(node.Right)

    // If current node is robbed (include), its children cannot be robbed.
    // So, we take the value of the current node + the max money from children when they are not robbed.
    include := node.Val + leftRes[0] + rightRes[0]

    // If current node is not robbed (exclude), its children can be robbed or not.
    // So, we take the maximum possible money from each child (either robbed or not).
    exclude := max(leftRes[0], leftRes[1]) + max(rightRes[0], rightRes[1])

    return [2]int{exclude, include}
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}