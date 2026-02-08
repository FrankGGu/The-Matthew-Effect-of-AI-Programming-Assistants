/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */
func deepestLeavesSum(root *TreeNode) int {
    if root == nil {
        return 0
    }

    queue := []*TreeNode{root}
    sum := 0

    for len(queue) > 0 {
        levelSize := len(queue)
        sum = 0

        for i := 0; i < levelSize; i++ {
            node := queue[0]
            queue = queue[1:]
            sum += node.Val

            if node.Left != nil {
                queue = append(queue, node.Left)
            }
            if node.Right != nil {
                queue = append(queue, node.Right)
            }
        }
    }

    return sum
}