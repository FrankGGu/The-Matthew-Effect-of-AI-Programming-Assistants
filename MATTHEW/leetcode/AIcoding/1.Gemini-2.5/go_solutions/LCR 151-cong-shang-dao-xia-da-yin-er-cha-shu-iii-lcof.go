func zigzagLevelOrder(root *TreeNode) [][]int {
    if root == nil {
        return [][]int{}
    }

    result := [][]int{}
    queue := []*TreeNode{root}
    levelNum := 0

    for len(queue) > 0 {
        levelSize := len(queue)
        currentLevelVals := []int{}

        for i := 0; i < levelSize; i++ {
            node := queue[0]
            queue = queue[1:] // Dequeue

            currentLevelVals = append(currentLevelVals, node.Val)

            if node.Left != nil {
                queue = append(queue, node.Left)
            }
            if node.Right != nil {
                queue = append(queue, node.Right)
            }
        }

        // If it's an odd level (0-indexed: 1, 3, 5, ...), reverse the values
        if levelNum % 2 == 1 {
            // In-place reverse
            for i, j := 0, len(currentLevelVals)-1; i < j; i, j = i+1, j-1 {
                currentLevelVals[i], currentLevelVals[j] = currentLevelVals[j], currentLevelVals[i]
            }
        }

        result = append(result, currentLevelVals)
        levelNum++
    }

    return result
}