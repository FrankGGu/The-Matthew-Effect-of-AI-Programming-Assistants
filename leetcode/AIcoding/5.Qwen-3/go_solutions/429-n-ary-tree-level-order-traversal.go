package main



func levelOrder(root *Node) [][]int {
    result := [][]int{}
    if root == nil {
        return result
    }

    queue := []*Node{root}

    for len(queue) > 0 {
        levelSize := len(queue)
        level := []int{}

        for i := 0; i < levelSize; i++ {
            node := queue[0]
            queue = queue[1:]
            level = append(level, node.Val)

            for _, child := range node.Children {
                queue = append(queue, child)
            }
        }

        result = append(result, level)
    }

    return result
}