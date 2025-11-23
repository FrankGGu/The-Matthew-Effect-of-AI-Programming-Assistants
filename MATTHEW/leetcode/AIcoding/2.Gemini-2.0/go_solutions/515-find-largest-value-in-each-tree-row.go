func largestValues(root *TreeNode) []int {
    if root == nil {
        return []int{}
    }

    result := []int{}
    queue := []*TreeNode{root}

    for len(queue) > 0 {
        levelSize := len(queue)
        maxVal := -1 << 63 // Initialize with smallest possible int

        for i := 0; i < levelSize; i++ {
            node := queue[0]
            queue = queue[1:]

            if node.Val > maxVal {
                maxVal = node.Val
            }

            if node.Left != nil {
                queue = append(queue, node.Left)
            }

            if node.Right != nil {
                queue = append(queue, node.Right)
            }
        }

        result = append(result, maxVal)
    }

    return result
}