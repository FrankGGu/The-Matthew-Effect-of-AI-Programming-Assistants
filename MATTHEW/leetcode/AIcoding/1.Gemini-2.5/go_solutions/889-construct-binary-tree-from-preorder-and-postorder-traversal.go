func constructFromPrePost(preorder []int, postorder []int) *TreeNode {
    n := len(preorder)

    if n == 0 {