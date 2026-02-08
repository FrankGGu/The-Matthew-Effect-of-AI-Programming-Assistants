/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */

var cameras int

func minCameraCover(root *TreeNode) int {
    cameras = 0
    if dfs(root) == 0 {
        cameras++
    }
    return cameras
}

func dfs(node *TreeNode) int {
    if node == nil {
        return 2
    }
    left := dfs(node.Left)
    right := dfs(node.Right)

    if left == 0 || right == 0 {
        cameras++
        return 1
    }
    if left == 1 || right == 1 {
        return 2
    }
    return 0
}