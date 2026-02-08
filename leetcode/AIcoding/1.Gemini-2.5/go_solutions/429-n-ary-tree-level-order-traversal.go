func levelOrder(root *Node) [][]int {
    if root == nil {
        return [][]int{}
    }

    result := [][]int{}
    queue := []*Node{root}

    for len(queue) > 0 {
        levelSize := len(queue)
        currentLevelVals := []int{}

        for i := 0; i < levelSize; i++ {
            node := queue[0]
            queue = queue[1:]

            currentLevelVals = append(currentLevelVals, node.Val)

            for _, child := range node.Children {
                if child != nil {
                    queue = append(queue, child)
                }
            }
        }
        result = append(result, currentLevelVals)
    }

    return result
}