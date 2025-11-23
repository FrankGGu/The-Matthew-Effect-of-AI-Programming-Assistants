/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */
func minimalExecTime(root *TreeNode) float64 {
    var dfs func(*TreeNode) (float64, float64)
    dfs = func(node *TreeNode) (float64, float64) {
        if node == nil {
            return 0.0, 0.0
        }
        leftTotal, leftParallel := dfs(node.Left)
        rightTotal, rightParallel := dfs(node.Right)
        total := leftTotal + rightTotal + float64(node.Val)
        if leftTotal < rightTotal {
            leftTotal, rightTotal = rightTotal, leftTotal
            leftParallel, rightParallel = rightParallel, leftParallel
        }
        if leftTotal - 2 * leftParallel <= rightTotal {
            parallel := (leftTotal + rightTotal) / 2
            return total, parallel
        } else {
            parallel := rightTotal + leftParallel
            return total, parallel
        }
    }
    total, parallel := dfs(root)
    return total - parallel
}