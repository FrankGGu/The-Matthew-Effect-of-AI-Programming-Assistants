package main


func buildTree(inorder []int, postorder []int) *TreeNode {
    if len(inorder) == 0 {
        return nil
    }
    rootVal := postorder[len(postorder)-1]
    root := &TreeNode{Val: rootVal}
    var index int
    for i, val := range inorder {
        if val == rootVal {
            index = i
            break
        }
    }
    root.Left = buildTree(inorder[:index], postorder[:index])
    root.Right = buildTree(inorder[index+1:], postorder[index:len(postorder)-1])
    return root
}