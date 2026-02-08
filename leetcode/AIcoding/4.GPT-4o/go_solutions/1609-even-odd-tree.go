type TreeNode struct {
    Val   int
    Left  *TreeNode
    Right *TreeNode
}

func isEvenOddTree(root *TreeNode) bool {
    if root == nil {
        return true
    }

    queue := []*TreeNode{root}
    level := 0

    for len(queue) > 0 {
        levelSize := len(queue)
        prev := -1

        for i := 0; i < levelSize; i++ {
            node := queue[0]
            queue = queue[1:]

            if level%2 == 0 {
                if node.Val%2 == 0 || (i > 0 && node.Val <= prev) {
                    return false
                }
            } else {
                if node.Val%2 != 0 || (i > 0 && node.Val >= prev) {
                    return false
                }
            }

            prev = node.Val
            if node.Left != nil {
                queue = append(queue, node.Left)
            }
            if node.Right != nil {
                queue = append(queue, node.Right)
            }
        }
        level++
    }

    return true
}