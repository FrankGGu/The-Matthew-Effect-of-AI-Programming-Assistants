/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val   int
 *     Left  *TreeNode
 *     Right *TreeNode
 * }
 */

func sumEvenGrandparent(root *TreeNode) int {
    return dfs(root, nil, nil)
}

func dfs(node, parent, grandparent *TreeNode) int {
    if node == nil {
        return 0
    }
    sum := 0
    if grandparent != nil && grandparent.Val%2 == 0 {
        sum += node.Val
    }
    sum += dfs(node.Left, node, parent)
    sum += dfs(node.Right, node, parent)
    return sum
}