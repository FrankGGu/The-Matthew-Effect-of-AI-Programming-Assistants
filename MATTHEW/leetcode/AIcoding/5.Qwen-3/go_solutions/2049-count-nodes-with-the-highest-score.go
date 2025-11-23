package main


func countHighestScoreNodes(root *TreeNode) int {
    var maxScore int
    var count int

    var dfs func(*TreeNode) int
    dfs = func(node *TreeNode) int {
        if node == nil {
            return 0
        }

        left := dfs(node.Left)
        right := dfs(node.Right)

        score := 1
        if left > 0 {
            score *= left
        }
        if right > 0 {
            score *= right
        }

        if score > maxScore {
            maxScore = score
            count = 1
        } else if score == maxScore {
            count++
        }

        return left + right + 1
    }

    dfs(root)
    return count
}