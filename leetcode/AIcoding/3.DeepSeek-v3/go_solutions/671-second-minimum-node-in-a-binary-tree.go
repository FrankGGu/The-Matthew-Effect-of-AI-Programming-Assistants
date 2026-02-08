/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */
func findSecondMinimumValue(root *TreeNode) int {
    minVal := root.Val
    secondMin := -1

    var dfs func(*TreeNode)
    dfs = func(node *TreeNode) {
        if node == nil {
            return
        }
        if node.Val > minVal {
            if secondMin == -1 || node.Val < secondMin {
                secondMin = node.Val
            }
        }
        dfs(node.Left)
        dfs(node.Right)
    }

    dfs(root)
    return secondMin
}