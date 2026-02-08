package main


func maxLevelSum(root *TreeNode) int {
    if root == nil {
        return 0
    }

    var queue []*TreeNode
    queue = append(queue, root)
    maxSum := -1 << 31
    level := 0
    resultLevel := 0

    for len(queue) > 0 {
        level++
        size := len(queue)
        currentSum := 0

        for i := 0; i < size; i++ {
            node := queue[0]
            queue = queue[1:]
            currentSum += node.Val

            if node.Left != nil {
                queue = append(queue, node.Left)
            }
            if node.Right != nil {
                queue = append(queue, node.Right)
            }
        }

        if currentSum > maxSum {
            maxSum = currentSum
            resultLevel = level
        }
    }

    return resultLevel
}