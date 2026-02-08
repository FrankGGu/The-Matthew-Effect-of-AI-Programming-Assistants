import "math"

func maxLevelSum(root *TreeNode) int {
    if root == nil {
        return 0 
    }

    maxSum := math.MinInt64
    maxLevel := 1
    currentLevel := 1

    queue := []*TreeNode{root}

    for len(queue) > 0 {
        levelSize := len(queue)
        currentLevelSum := 0

        for i := 0; i < levelSize; i++ {
            node := queue[0]
            queue = queue[1:] 

            currentLevelSum += node.Val

            if node.Left != nil {
                queue = append(queue, node.Left)
            }
            if node.Right != nil {
                queue = append(queue, node.Right)
            }
        }

        if currentLevelSum > maxSum {
            maxSum = currentLevelSum
            maxLevel = currentLevel
        }
        currentLevel++
    }

    return maxLevel
}