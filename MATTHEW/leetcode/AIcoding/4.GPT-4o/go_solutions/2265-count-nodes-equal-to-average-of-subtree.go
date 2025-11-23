/**
 * Definition for a binary tree node.
 */
type TreeNode struct {
    Val   int
    Left  *TreeNode
    Right *TreeNode
}

func averageOfSubtree(root *TreeNode) int {
    count := 0
    var dfs func(node *TreeNode) (sum, num int)
    dfs = func(node *TreeNode) (sum, num int) {
        if node == nil {
            return 0, 0
        }
        leftSum, leftNum := dfs(node.Left)
        rightSum, rightNum := dfs(node.Right)
        totalSum := leftSum + rightSum + node.Val
        totalNum := leftNum + rightNum + 1
        if totalSum/totalNum == node.Val {
            count++
        }
        return totalSum, totalNum
    }
    dfs(root)
    return count
}