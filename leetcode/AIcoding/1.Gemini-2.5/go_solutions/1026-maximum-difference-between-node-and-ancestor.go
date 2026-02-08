func maxAncestorDiff(root *TreeNode) int {
    if root == nil {
        return 0
    }

    minFunc := func(a, b int) int {
        if a < b {
            return a
        }
        return b
    }
    maxFunc := func(a, b int) int {
        if a > b {
            return a
        }
        return b
    }
    absFunc := func(a int) int {
        if a < 0 {
            return -a
        }
        return a
    }

    var dfs func(node *TreeNode, currentMin int, currentMax int) int
    dfs = func(node *TreeNode, currentMin int, currentMax int) int {
        if node == nil {
            return 0
        }

        diff1 := absFunc(node.Val - currentMin)
        diff2 := absFunc(node.Val - currentMax)
        maxDiff := maxFunc(diff1, diff2)

        newMin := minFunc(currentMin, node.Val)
        newMax := maxFunc(currentMax, node.Val)

        leftMaxDiff := dfs(node.Left, newMin, newMax)
        rightMaxDiff := dfs(node.Right, newMin, newMax)

        return maxFunc(maxDiff, maxFunc(leftMaxDiff, rightMaxDiff))
    }

    return dfs(root, root.Val, root.Val)
}