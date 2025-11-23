func zigzagLevelOrder(root *TreeNode, label int) []int {
    if root == nil {
        return []int{}
    }

    level := 0
    result := []int{}
    currentLabel := 1
    queue := []*TreeNode{root}

    for len(queue) > 0 {
        size := len(queue)
        levelLabels := []int{}

        for i := 0; i < size; i++ {
            node := queue[0]
            queue = queue[1:]
            levelLabels = append(levelLabels, currentLabel)
            currentLabel++

            if node.Left != nil {
                queue = append(queue, node.Left)
            }
            if node.Right != nil {
                queue = append(queue, node.Right)
            }
        }

        if level%2 == 1 {
            reverse(levelLabels)
        }

        for _, val := range levelLabels {
            if val == label {
                return result
            }
            result = append(result, val)
        }

        level++
    }

    return result
}

func reverse(arr []int) {
    for i, j := 0, len(arr)-1; i < j; i, j = i+1, j-1 {
        arr[i], arr[j] = arr[j], arr[i]
    }
}