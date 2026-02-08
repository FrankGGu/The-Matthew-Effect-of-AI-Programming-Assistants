/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */

func postorderTraversal(root *TreeNode) []int {
    result := []int{}
    var helper func(node *TreeNode)
    helper = func(node *TreeNode) {
        if node == nil {
            return
        }
        helper(node.Left)
        helper(node.Right)
        result = append(result, node.Val)
    }
    helper(root)
    return result
}