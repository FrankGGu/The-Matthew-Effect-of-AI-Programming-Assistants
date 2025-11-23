/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val   int
 *     Left  *TreeNode
 *     Right *TreeNode
 * }
 */

func findTarget(root *TreeNode, k int) bool {
    set := make(map[int]struct{})
    return dfs(root, k, set)
}

func dfs(node *TreeNode, k int, set map[int]struct{}) bool {
    if node == nil {
        return false
    }
    if _, exists := set[k-node.Val]; exists {
        return true
    }
    set[node.Val] = struct{}{}
    return dfs(node.Left, k, set) || dfs(node.Right, k, set)
}