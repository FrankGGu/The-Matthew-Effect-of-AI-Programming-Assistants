package main


func constructFromPrePost(preorder []int, postorder []int) *TreeNode {
    if len(preorder) == 0 {
        return nil
    }
    if len(preorder) == 1 {
        return &TreeNode{Val: preorder[0]}
    }
    root := &TreeNode{Val: preorder[0]}
    leftVal := preorder[1]
    index := 0
    for i, v := range postorder {
        if v == leftVal {
            index = i
            break
        }
    }
    root.Left = constructFromPrePost(preorder[1:index+2], postorder[:index+1])
    root.Right = constructFromPrePost(preorder[index+2:], postorder[index+1:])
    return root
}