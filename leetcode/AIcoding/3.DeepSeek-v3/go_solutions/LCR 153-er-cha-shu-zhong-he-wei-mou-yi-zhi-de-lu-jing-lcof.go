/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */
func pathSum(root *TreeNode, targetSum int) [][]int {
    var result [][]int
    var path []int
    var dfs func(*TreeNode, int)
    dfs = func(node *TreeNode, sum int) {
        if node == nil {
            return
        }
        sum += node.Val
        path = append(path, node.Val)
        defer func() { path = path[:len(path)-1] }()
        if node.Left == nil && node.Right == nil && sum == targetSum {
            result = append(result, append([]int(nil), path...))
            return
        }
        dfs(node.Left, sum)
        dfs(node.Right, sum)
    }
    dfs(root, 0)
    return result
}