/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */
func btreeGameWinningMove(root *TreeNode, n int, x int) bool {
    var left, right int
    countNodes(root, x, &left, &right)
    parent := n - left - right - 1
    max := parent
    if left > max {
        max = left
    }
    if right > max {
        max = right
    }
    return max > n/2
}

func countNodes(node *TreeNode, x int, left, right *int) int {
    if node == nil {
        return 0
    }
    l := countNodes(node.Left, x, left, right)
    r := countNodes(node.Right, x, left, right)
    if node.Val == x {
        *left = l
        *right = r
    }
    return l + r + 1
}