/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */
func rob(root *TreeNode) int {
    res := robHelper(root)
    return max(res[0], res[1])
}

func robHelper(node *TreeNode) []int {
    if node == nil {
        return []int{0, 0}
    }
    left := robHelper(node.Left)
    right := robHelper(node.Right)
    robCurrent := node.Val + left[1] + right[1]
    notRobCurrent := max(left[0], left[1]) + max(right[0], right[1])
    return []int{robCurrent, notRobCurrent}
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}