/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val   int
 *     Left  *TreeNode
 *     Right *TreeNode
 * }
 */

func sumNumbers(root *TreeNode) int {
    return sum(root, 0)
}

func sum(node *TreeNode, currentSum int) int {
    if node == nil {
        return 0
    }
    currentSum = currentSum*10 + node.Val
    if node.Left == nil && node.Right == nil {
        return currentSum
    }
    return sum(node.Left, currentSum) + sum(node.Right, currentSum)
}