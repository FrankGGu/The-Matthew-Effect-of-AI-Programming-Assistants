func buildTree(preorder []int, inorder []int) *TreeNode {
    if len(preorder) == 0 || len(inorder) == 0 {
        return nil
    }

    inorderMap := make(map[int]int)
    for i, val := range inorder {
        inorderMap[val] = i
    }

    var build func(preStart, preEnd, inStart, inEnd int) *TreeNode
    build = func(preStart, preEnd, inStart, inEnd int) *TreeNode {
        if preStart > preEnd || inStart > inEnd {
            return nil
        }

        rootVal := preorder[preStart]
        root := &TreeNode{Val: rootVal}

        inRootIdx := inorderMap[rootVal]
        numsLeft := inRootIdx - inStart

        root.Left = build(preStart + 1, preStart + numsLeft, inStart, inRootIdx - 1)
        root.Right = build(preStart + numsLeft + 1, preEnd, inRootIdx + 1, inEnd)

        return root
    }

    return build(0, len(preorder)-1, 0, len(inorder)-1)
}

type TreeNode struct {
    Val int
    Left *TreeNode
    Right *TreeNode
}