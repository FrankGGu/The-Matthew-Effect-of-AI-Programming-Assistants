/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */

func constructFromPrePost(preorder []int, postorder []int) *TreeNode {
    if len(preorder) == 0 || len(postorder) == 0 {
        return nil
    }
    root := &TreeNode{Val: preorder[0]}
    if len(preorder) == 1 {
        return root
    }
    leftRootVal := preorder[1]
    leftSubtreeSize := 0
    for i := 0; i < len(postorder); i++ {
        if postorder[i] == leftRootVal {
            leftSubtreeSize = i + 1
            break
        }
    }
    root.Left = constructFromPrePost(preorder[1:leftSubtreeSize+1], postorder[:leftSubtreeSize])
    root.Right = constructFromPrePost(preorder[leftSubtreeSize+1:], postorder[leftSubtreeSize:len(postorder)-1])
    return root
}