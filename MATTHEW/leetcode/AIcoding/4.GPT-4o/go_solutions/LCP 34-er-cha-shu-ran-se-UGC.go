/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */
func colorBinaryTree(root *TreeNode, color int) *TreeNode {
    if root == nil {
        return nil
    }
    root.Val = color
    colorBinaryTree(root.Left, color)
    colorBinaryTree(root.Right, color)
    return root
}