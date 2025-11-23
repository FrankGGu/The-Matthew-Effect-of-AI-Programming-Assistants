/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */
func delNodes(root *TreeNode, to_delete []int) []*TreeNode {
    deleteSet := make(map[int]bool)
    for _, val := range to_delete {
        deleteSet[val] = true
    }
    var forest []*TreeNode
    var dfs func(*TreeNode, bool) *TreeNode
    dfs = func(node *TreeNode, isRoot bool) *TreeNode {
        if node == nil {
            return nil
        }
        deleted := deleteSet[node.Val]
        if isRoot && !deleted {
            forest = append(forest, node)
        }
        node.Left = dfs(node.Left, deleted)
        node.Right = dfs(node.Right, deleted)
        if deleted {
            return nil
        }
        return node
    }
    dfs(root, true)
    return forest
}