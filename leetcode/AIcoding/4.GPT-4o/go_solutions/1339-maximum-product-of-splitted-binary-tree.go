/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */
func maxProduct(root *TreeNode) int {
    var totalSum int
    var dfs func(node *TreeNode) int
    dfs = func(node *TreeNode) int {
        if node == nil {
            return 0
        }
        sum := node.Val + dfs(node.Left) + dfs(node.Right)
        totalSum += sum
        return sum
    }
    dfs(root)

    var maxProd int
    var findMaxProd func(node *TreeNode) int
    findMaxProd = func(node *TreeNode) int {
        if node == nil {
            return 0
        }
        sum := node.Val + findMaxProd(node.Left) + findMaxProd(node.Right)
        prod := sum * (totalSum - sum)
        if prod > maxProd {
            maxProd = prod
        }
        return sum
    }
    findMaxProd(root)

    return maxProd % (1e9 + 7)
}