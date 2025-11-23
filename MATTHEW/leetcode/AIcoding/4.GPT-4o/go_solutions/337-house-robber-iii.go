/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */
func rob(root *TreeNode) int {
    money := robTree(root)
    return max(money[0], money[1])
}

func robTree(node *TreeNode) []int {
    if node == nil {
        return []int{0, 0}
    }

    left := robTree(node.Left)
    right := robTree(node.Right)

    // 0: not robbing this node, 1: robbing this node
    notRob := max(left[0], left[1]) + max(right[0], right[1])
    rob := node.Val + left[0] + right[0]

    return []int{notRob, rob}
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}