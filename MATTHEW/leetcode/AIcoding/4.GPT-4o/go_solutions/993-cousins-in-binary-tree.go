/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */

func isCousins(root *TreeNode, x int, y int) bool {
    var parentX, parentY *TreeNode
    var depthX, depthY int

    var dfs func(node *TreeNode, parent *TreeNode, depth int, target int) bool
    dfs = func(node *TreeNode, parent *TreeNode, depth int, target int) bool {
        if node == nil {
            return false
        }
        if node.Val == target {
            if target == x {
                parentX = parent
                depthX = depth
            } else {
                parentY = parent
                depthY = depth
            }
            return true
        }
        return dfs(node.Left, node, depth+1, target) || dfs(node.Right, node, depth+1, target)
    }

    dfs(root, nil, 0, x)
    dfs(root, nil, 0, y)

    return parentX != parentY && depthX == depthY
}