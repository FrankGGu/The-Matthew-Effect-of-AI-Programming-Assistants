type TreeNode struct {
    Val   int
    Left  *TreeNode
    Right *TreeNode
}

func countHighestScoreNodes(root *TreeNode) int {
    var count int
    var maxScore int
    var totalNodes int

    var dfs func(node *TreeNode) int
    dfs = func(node *TreeNode) int {
        if node == nil {
            return 0
        }
        leftCount := dfs(node.Left)
        rightCount := dfs(node.Right)
        currentCount := leftCount + rightCount + 1
        score := 1
        if node.Left != nil {
            score *= leftCount
        }
        if node.Right != nil {
            score *= rightCount
        }
        if currentCount != totalNodes {
            score *= totalNodes - currentCount
        }
        if score > maxScore {
            maxScore = score
            count = 1
        } else if score == maxScore {
            count++
        }
        return currentCount
    }

    totalNodes = dfs(root)
    dfs(root)
    return count
}