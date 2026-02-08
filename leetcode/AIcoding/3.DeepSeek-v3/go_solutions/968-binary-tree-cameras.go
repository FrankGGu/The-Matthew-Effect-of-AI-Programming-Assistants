/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */

const (
    COVERED = 0
    NOT_COVERED = 1
    CAMERA = 2
)

func minCameraCover(root *TreeNode) int {
    res := 0
    var dfs func(node *TreeNode) int
    dfs = func(node *TreeNode) int {
        if node == nil {
            return COVERED
        }
        left := dfs(node.Left)
        right := dfs(node.Right)

        if left == NOT_COVERED || right == NOT_COVERED {
            res++
            return CAMERA
        }

        if left == CAMERA || right == CAMERA {
            return COVERED
        }

        return NOT_COVERED
    }

    if dfs(root) == NOT_COVERED {
        res++
    }
    return res
}