func findBottomLeftValue(root *TreeNode) int {
    if root == nil {
        return 0 // Or handle error based on problem constraints
    }

    queue := []*TreeNode{root}
    var bottomLeftValue int

    for len(queue) > 0 {
        levelSize := len(queue)

        // The first node in the current level is the leftmost node of this level.
        // Since we process levels from top to bottom, the last time this variable
        // is updated will be for the bottommost level.
        bottomLeftValue = queue[0].Val 

        for i := 0; i < levelSize; i++ {
            node := queue[0]
            queue = queue[1:] // Dequeue

            if node.Left != nil {
                queue = append(queue, node.Left)
            }
            if node.Right != nil {
                queue = append(queue, node.Right)
            }
        }
    }

    return bottomLeftValue
}