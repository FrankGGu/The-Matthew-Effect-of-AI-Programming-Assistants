package main


func findBottomLeftValue(root *TreeNode) int {
    var queue []*TreeNode
    queue = append(queue, root)
    var result int
    for len(queue) > 0 {
        levelSize := len(queue)
        for i := 0; i < levelSize; i++ {
            node := queue[0]
            queue = queue[1:]
            if i == 0 {
                result = node.Val
            }
            if node.Left != nil {
                queue = append(queue, node.Left)
            }
            if node.Right != nil {
                queue = append(queue, node.Right)
            }
        }
    }
    return result
}