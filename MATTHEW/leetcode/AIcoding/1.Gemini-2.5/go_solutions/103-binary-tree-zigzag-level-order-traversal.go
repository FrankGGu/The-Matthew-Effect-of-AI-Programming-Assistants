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
        nextQueue := []*TreeNode{}

        for i := 0; i < levelSize; i++ {
            node := queue[i]
            currentLevelVals = append(currentLevelVals, node.Val)

            if node.Left != nil {
                nextQueue = append(nextQueue, node.Left)
            }
            if node.Right != nil {
                nextQueue = append(nextQueue, node.Right)
            }
        }

        if levelNum%2 == 1 {
            for i, j := 0, len(currentLevelVals)-1; i < j; i, j = i+1, j-1 {
                currentLevelVals[i], currentLevelVals[j] = currentLevelVals[j], currentLevelVals[i]
            }
        }

        result = append(result, currentLevelVals)
        queue = nextQueue
        levelNum++
    }

    return result
}