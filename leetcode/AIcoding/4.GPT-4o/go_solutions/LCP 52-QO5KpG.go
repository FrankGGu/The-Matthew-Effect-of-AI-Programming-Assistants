/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val   int
 *     Left  *TreeNode
 *     Right *TreeNode
 * }
 */

func colorTree(root *TreeNode) int {
    if root == nil {
        return 0
    }
    return 1 + colorTree(root.Left) + colorTree(root.Right)
}