/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */
func maxProduct(root *TreeNode) int {
    const mod = 1e9 + 7
    var totalSum int
    var sums []int

    var dfs func(*TreeNode) int
    dfs = func(node *TreeNode) int {
        if node == nil {
            return 0
        }
        sum := node.Val + dfs(node.Left) + dfs(node.Right)
        sums = append(sums, sum)
        return sum
    }

    totalSum = dfs(root)
    maxProd := 0
    for _, sum := range sums {
        if sum != totalSum {
            prod := sum * (totalSum - sum)
            if prod > maxProd {
                maxProd = prod
            }
        }
    }
    return maxProd % mod
}