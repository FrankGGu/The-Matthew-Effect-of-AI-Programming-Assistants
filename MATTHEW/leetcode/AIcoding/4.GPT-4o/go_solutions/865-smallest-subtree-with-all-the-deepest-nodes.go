/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val   int
 *     Left  *TreeNode
 *     Right *TreeNode
 * }
 */

func subtreeWithAllDeepest(root *TreeNode) *TreeNode {
    var dfs func(node *TreeNode) (depth int, node *TreeNode)
    dfs = func(node *TreeNode) (depth int, node *TreeNode) {
        if node == nil {
            return 0, nil
        }
        leftDepth, leftNode := dfs(node.Left)
        rightDepth, rightNode := dfs(node.Right)
        if leftDepth > rightDepth {
            return leftDepth + 1, leftNode
        } else if rightDepth > leftDepth {
            return rightDepth + 1, rightNode
        }
        return leftDepth + 1, node
    }
    _, result := dfs(root)
    return result
}