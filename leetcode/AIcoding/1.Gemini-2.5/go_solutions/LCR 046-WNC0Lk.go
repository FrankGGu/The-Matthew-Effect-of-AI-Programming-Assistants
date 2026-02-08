func rightSideView(root *TreeNode) []int {
    var result []int
    if root == nil {
        return result
    }

    queue := []*TreeNode{root}

    for len(queue) > 0 {
        levelSize := len(queue)
        var rightmostNodeVal int

        for i := 0; i < levelSize; i++ {
            node := queue[0]
            queue = queue[1:]

            rightmostNodeVal = node.Val // This will store the value of the last node in the current level

            if node.Left != nil {
                queue = append(queue, node.Left)
            }
            if node.Right != nil {
                queue = append(queue, node.Right)
            }
        }
        result = append(result, rightmostNodeVal)
    }

    return result
}