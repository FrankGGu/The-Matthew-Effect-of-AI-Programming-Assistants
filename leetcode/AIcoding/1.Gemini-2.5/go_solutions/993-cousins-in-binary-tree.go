func isCousins(root *TreeNode, x int, y int) bool {
    var findInfo func(node *TreeNode, target int, currentDepth int, parent *TreeNode) (int, *TreeNode)
    findInfo = func(node *TreeNode, target int, currentDepth int, parent *TreeNode) (int, *TreeNode) {
        if node == nil {
            return -1, nil
        }
        if node.Val == target {
            return currentDepth, parent
        }

        depth, p := findInfo(node.Left, target, currentDepth+1, node)
        if depth != -1 {
            return depth, p
        }

        return findInfo(node.Right, target, currentDepth+1, node)
    }

    depthX, parentX := findInfo(root, x, 0, nil)
    depthY, parentY := findInfo(root, y, 0, nil)

    return depthX == depthY && parentX != parentY
}