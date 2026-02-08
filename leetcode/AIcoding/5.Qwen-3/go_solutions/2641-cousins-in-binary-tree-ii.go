package main


func updateTree(root *TreeNode) *TreeNode {
    if root == nil {
        return nil
    }
    var queue []*TreeNode
    queue = append(queue, root)
    for len(queue) > 0 {
        levelSize := len(queue)
        sum := 0
        for i := 0; i < levelSize; i++ {
            node := queue[i]
            sum += node.Val
        }
        for i := 0; i < levelSize; i++ {
            node := queue[i]
            node.Val = sum - node.Val
            if node.Left != nil {
                queue = append(queue, node.Left)
            }
            if node.Right != nil {
                queue = append(queue, node.Right)
            }
        }
        queue = queue[levelSize:]
    }
    return root
}