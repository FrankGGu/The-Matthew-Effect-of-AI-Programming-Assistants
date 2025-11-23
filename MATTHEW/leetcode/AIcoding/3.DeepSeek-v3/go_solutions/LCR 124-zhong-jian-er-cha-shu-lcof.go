/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */
func buildTree(inorder []int, postorder []int) *TreeNode {
    if len(inorder) == 0 {
        return nil
    }
    rootVal := postorder[len(postorder)-1]
    root := &TreeNode{Val: rootVal}
    var idx int
    for i, v := range inorder {
        if v == rootVal {
            idx = i
            break
        }
    }
    root.Left = buildTree(inorder[:idx], postorder[:idx])
    root.Right = buildTree(inorder[idx+1:], postorder[idx:len(postorder)-1])
    return root
}