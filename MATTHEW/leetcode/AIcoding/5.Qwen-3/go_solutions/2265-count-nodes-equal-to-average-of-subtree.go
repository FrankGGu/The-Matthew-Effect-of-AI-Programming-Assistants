package main


func averageOfSubtree(root *TreeNode) int {
    count := 0
    var dfs func(*TreeNode) (int, int)
    dfs = func(node *TreeNode) (int, int) {
        if node == nil {
            return 0, 0
        }
        leftSum, leftCount := dfs(node.Left)
        rightSum, rightCount := dfs(node.Right)
        totalSum := leftSum + rightSum + node.Val
        totalCount := leftCount + rightCount + 1
        if totalSum / totalCount == node.Val {
            count++
        }
        return totalSum, totalCount
    }
    dfs(root)
    return count
}