/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val   int
 *     Left  *TreeNode
 *     Right *TreeNode
 * }
 */

func getMinimumDifference(root *TreeNode) int {
    prev, minDiff := -1, int(^uint(0) >> 1)
    var inorder func(node *TreeNode)

    inorder = func(node *TreeNode) {
        if node == nil {
            return
        }
        inorder(node.Left)
        if prev != -1 {
            minDiff = min(minDiff, node.Val - prev)
        }
        prev = node.Val
        inorder(node.Right)
    }

    inorder(root)
    return minDiff
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}