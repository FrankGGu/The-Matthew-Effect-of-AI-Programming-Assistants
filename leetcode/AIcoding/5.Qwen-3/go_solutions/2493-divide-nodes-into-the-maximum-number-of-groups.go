package main


func isEvenOddTree(root *TreeNode) bool {
    if root == nil {
        return true
    }
    queue := []*TreeNode{root}
    level := 0
    for len(queue) > 0 {
        size := len(queue)
        prevVal := -1
        for i := 0; i < size; i++ {
            node := queue[0]
            queue = queue[1:]
            if level%2 == 0 {
                if node.Val%2 == 0 || (prevVal != -1 && node.Val <= prevVal) {
                    return false
                }
            } else {
                if node.Val%2 == 1 || (prevVal != -1 && node.Val >= prevVal) {
                    return false
                }
            }
            prevVal = node.Val
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