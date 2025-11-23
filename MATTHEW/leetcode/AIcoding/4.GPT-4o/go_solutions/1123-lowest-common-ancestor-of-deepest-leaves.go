/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val   int
 *     Left  *TreeNode
 *     Right *TreeNode
 * }
 */

func lcaDeepestLeaves(root *TreeNode) *TreeNode {
    var lca func(node *TreeNode) (*TreeNode, int)
    lca = func(node *TreeNode) (*TreeNode, int) {
        if node == nil {
            return nil, 0
        }
        leftLCA, leftDepth := lca(node.Left)
        rightLCA, rightDepth := lca(node.Right)
        if leftDepth > rightDepth {
            return leftLCA, leftDepth + 1
        } else if rightDepth > leftDepth {
            return rightLCA, rightDepth + 1
        } else {
            return node, leftDepth + 1
        }
    }
    result, _ := lca(root)
    return result
}