/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */
func findDuplicateSubtrees(root *TreeNode) []*TreeNode {
    var res []*TreeNode
    m := make(map[string]int)
    var traverse func(node *TreeNode) string
    traverse = func(node *TreeNode) string {
        if node == nil {
            return "#"
        }
        left := traverse(node.Left)
        right := traverse(node.Right)
        subtree := fmt.Sprintf("%d,%s,%s", node.Val, left, right)
        m[subtree]++
        if m[subtree] == 2 {
            res = append(res, node)
        }
        return subtree
    }
    traverse(root)
    return res
}