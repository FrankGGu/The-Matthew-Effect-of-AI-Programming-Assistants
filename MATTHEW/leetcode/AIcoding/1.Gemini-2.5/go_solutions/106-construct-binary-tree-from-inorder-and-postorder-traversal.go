func buildTree(inorder []int, postorder []int) *TreeNode {
    if len(inorder) == 0 || len(postorder) == 0 {
        return nil
    }

    inorderMap := make(map[int]int)
    for i, val := range inorder {
        inorderMap[val] = i
    }

    var build func(inStart, inEnd, postStart, postEnd int) *TreeNode
    build = func(inStart, inEnd, postStart, postEnd int) *TreeNode {
        if inStart > inEnd || postStart > postEnd {
            return nil
        }

        // The last element in postorder is the root of the current subtree
        rootVal := postorder[postEnd]
        root := &TreeNode{Val: rootVal}

        // Find the root's index in inorder traversal
        rootInIndex := inorderMap[rootVal]

        // Calculate the number of elements in the left subtree
        numsLeft := rootInIndex - inStart

        // Recursively build the left subtree
        // Inorder for left: inStart to rootIn