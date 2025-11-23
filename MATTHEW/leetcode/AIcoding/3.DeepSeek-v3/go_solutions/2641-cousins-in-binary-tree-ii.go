/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */
func replaceValueInTree(root *TreeNode) *TreeNode {
    if root == nil {
        return nil
    }
    root.Val = 0
    q := []*TreeNode{root}
    for len(q) > 0 {
        nextLevel := []*TreeNode{}
        currentSum := 0
        for _, node := range q {
            if node.Left != nil {
                nextLevel = append(nextLevel, node.Left)
                currentSum += node.Left.Val
            }
            if node.Right != nil {
                nextLevel = append(nextLevel, node.Right)
                currentSum += node.Right.Val
            }
        }
        for _, node := range q {
            sum := 0
            if node.Left != nil {
                sum += node.Left.Val
            }
            if node.Right != nil {
                sum += node.Right.Val
            }
            if node.Left != nil {
                node.Left.Val = currentSum - sum
            }
            if node.Right != nil {
                node.Right.Val = currentSum - sum
            }
        }
        q = nextLevel
    }
    return root
}