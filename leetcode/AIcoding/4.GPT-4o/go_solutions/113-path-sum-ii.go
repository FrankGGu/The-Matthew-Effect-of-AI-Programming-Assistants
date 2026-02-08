/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */

func pathSum(root *TreeNode, sum int) [][]int {
    var result [][]int
    var path []int
    var dfs func(node *TreeNode, currentSum int)

    dfs = func(node *TreeNode, currentSum int) {
        if node == nil {
            return
        }
        path = append(path, node.Val)
        currentSum += node.Val

        if node.Left == nil && node.Right == nil && currentSum == sum {
            temp := make([]int, len(path))
            copy(temp, path)
            result = append(result, temp)
        }

        dfs(node.Left, currentSum)
        dfs(node.Right, currentSum)
        path = path[:len(path)-1]
    }

    dfs(root, 0)
    return result
}