/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */
func constructFromPrePost(preorder []int, postorder []int) *TreeNode {
    if len(preorder) == 0 {
        return nil
    }
    root := &TreeNode{Val: preorder[0]}
    if len(preorder) == 1 {
        return root
    }
    leftVal := preorder[1]
    leftCount := 0
    for i, val := range postorder {
        if val == leftVal {
            leftCount = i + 1
            break
        }
    }
    root.Left = constructFromPrePost(preorder[1:leftCount+1], postorder[:leftCount])
    root.Right = constructFromPrePost(preorder[leftCount+1:], postorder[leftCount:len(postorder)-1])
    return root
}