package main


func verticalOrder(root *TreeNode) [][]int {
    if root == nil {
        return [][]int{}
    }

    type pos struct {
        node *TreeNode
        col  int
    }

    from := 0
    to := 0
    queue := []pos{{root, 0}}
    cols := map[int][]int{}
    minCol := 0
    maxCol := 0

    for len(queue) > 0 {
        current := queue[0]
        queue = queue[1:]
        node := current.node
        col := current.col

        if _, ok := cols[col]; !ok {
            cols[col] = []int{}
        }
        cols[col] = append(cols[col], node.Val)

        if node.Left != nil {
            queue = append(queue, pos{node.Left, col - 1})
            if col - 1 < minCol {
                minCol = col - 1
            }
        }
        if node.Right != nil {
            queue = append(queue, pos{node.Right, col + 1})
            if col + 1 > maxCol {
                maxCol = col + 1
            }
        }
    }

    result := make([][]int, 0, maxCol-minCol+1)
    for i := minCol; i <= maxCol; i++ {
        result = append(result, cols[i])
    }

    return result
}