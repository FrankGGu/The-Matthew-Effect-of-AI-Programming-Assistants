/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */
func pathSum(root *TreeNode, targetSum int) int {
    prefixSum := make(map[int]int)
    prefixSum[0] = 1
    return dfs(root, targetSum, 0, prefixSum)
}

func dfs(node *TreeNode, targetSum, currentSum int, prefixSum map[int]int) int {
    if node == nil {
        return 0
    }
    currentSum += node.Val
    res := prefixSum[currentSum - targetSum]
    prefixSum[currentSum]++
    res += dfs(node.Left, targetSum, currentSum, prefixSum)
    res += dfs(node.Right, targetSum, currentSum, prefixSum)
    prefixSum[currentSum]--
    return res
}