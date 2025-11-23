/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val   int
 *     Left  *TreeNode
 *     Right *TreeNode
 * }
 */

func bstToGst(root *TreeNode) *TreeNode {
    var sum int
    var helper func(node *TreeNode)
    helper = func(node *TreeNode) {
        if node == nil {
            return
        }
        helper(node.Right)
        sum += node.Val
        node.Val = sum
        helper(node.Left)
    }
    helper(root)
    return root
}