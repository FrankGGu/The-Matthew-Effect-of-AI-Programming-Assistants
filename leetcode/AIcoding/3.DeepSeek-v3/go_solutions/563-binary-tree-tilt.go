/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */
func findTilt(root *TreeNode) int {
    totalTilt := 0
    var postOrder func(*TreeNode) int
    postOrder = func(node *TreeNode) int {
        if node == nil {
            return 0
        }
        leftSum := postOrder(node.Left)
        rightSum := postOrder(node.Right)
        tilt := abs(leftSum - rightSum)
        totalTilt += tilt
        return node.Val + leftSum + rightSum
    }
    postOrder(root)
    return totalTilt
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}