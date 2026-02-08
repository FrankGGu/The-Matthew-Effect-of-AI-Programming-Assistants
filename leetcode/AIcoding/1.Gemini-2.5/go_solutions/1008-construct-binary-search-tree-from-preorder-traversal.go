/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */
func bstFromPreorder(preorder []int) *TreeNode {
    if len(preorder) == 0 {
        return nil
    }
    root := &TreeNode{Val: preorder[0]}
    i := 1
    for i < len(preorder) && preorder[i] < root.Val {
        i++
    }
    root.Left = bstFromPreorder(preorder[1:i])
    root.Right = bstFromPreorder(preorder[i:])
    return root
}