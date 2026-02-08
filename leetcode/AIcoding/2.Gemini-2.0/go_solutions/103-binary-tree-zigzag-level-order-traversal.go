func zigzagLevelOrder(root *TreeNode) [][]int {
    if root == nil {
        return [][]int{}
    }

    result := [][]int{}
    queue := []*TreeNode{root}
    level := 0

    for len(queue) > 0 {
        levelSize := len(queue)
        levelValues := []int{}

        for i := 0; i < levelSize; i++ {
            node := queue[0]
            queue = queue[1:]
            levelValues = append(levelValues, node.Val)

            if node.Left != nil {
                queue = append(queue, node.Left)
            }
            if node.Right != nil {
                queue = append(queue, node.Right)
            }
        }

        if level%2 != 0 {
            for i, j := 0, len(levelValues)-1; i < j; i, j = i+1, j-1 {
                levelValues[i], levelValues[j] = levelValues[j], levelValues[i]
            }
        }

        result = append(result, levelValues)
        level++
    }

    return result
}