/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */

func findTarget(root *TreeNode, k int) bool {
    nums := make(map[int]bool)
    return dfs(root, k, nums)
}

func dfs(node *TreeNode, k int, nums map[int]bool) bool {
    if node == nil {
        return false
    }
    if nums[k-node.Val] {
        return true
    }
    nums[node.Val] = true
    return dfs(node.Left, k, nums) || dfs(node.Right, k, nums)
}