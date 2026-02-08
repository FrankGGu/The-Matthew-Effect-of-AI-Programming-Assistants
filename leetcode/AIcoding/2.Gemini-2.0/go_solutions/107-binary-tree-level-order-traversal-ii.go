func levelOrderBottom(root *TreeNode) [][]int {
    if root == nil {
        return [][]int{}
    }

    queue := []*TreeNode{root}
    result := [][]int{}

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

        result = append(result, levelValues)
    }

    for i, j := 0, len(result)-1; i < j; i, j = i+1, j-1 {
        result[i], result[j] = result[j], result[i]
    }

    return result
}