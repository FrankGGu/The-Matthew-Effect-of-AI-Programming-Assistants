type Node struct {
    Val      int
    Children []*Node
}

func levelOrder(root *Node) [][]int {
    if root == nil {
        return [][]int{}
    }
    result := [][]int{}
    queue := []*Node{root}

    for len(queue) > 0 {
        levelSize := len(queue)
        level := []int{}

        for i := 0; i < levelSize; i++ {
            node := queue[0]
            queue = queue[1:]
            level = append(level, node.Val)
            queue = append(queue, node.Children...)
        }

        result = append(result, level)
    }

    return result
}