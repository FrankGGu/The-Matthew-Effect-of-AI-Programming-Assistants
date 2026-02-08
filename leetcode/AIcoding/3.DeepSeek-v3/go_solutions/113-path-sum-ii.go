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
        path = append(path, node.Val)
        sum += node.Val
        if node.Left == nil && node.Right == nil && sum == targetSum {
            tmp := make([]int, len(path))
            copy(tmp, path)
            result = append(result, tmp)
        }
        dfs(node.Left, sum)
        dfs(node.Right, sum)
        path = path[:len(path)-1]
    }

    dfs(root, 0)
    return result
}