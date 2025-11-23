/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */
func addOneRow(root *TreeNode, val int, depth int) *TreeNode {
    if depth == 1 {
        return &TreeNode{Val: val, Left: root}
    }
    queue := []*TreeNode{root}
    currentDepth := 1
    for len(queue) > 0 {
        if currentDepth == depth-1 {
            for _, node := range queue {
                left := node.Left
                right := node.Right
                node.Left = &TreeNode{Val: val, Left: left}
                node.Right = &TreeNode{Val: val, Right: right}
            }
            break
        }
        levelSize := len(queue)
        for i := 0; i < levelSize; i++ {
            node := queue[0]
            queue = queue[1:]
            if node.Left != nil {
                queue = append(queue, node.Left)
            }
            if node.Right != nil {
                queue = append(queue, node.Right)
            }
        }
        currentDepth++
    }
    return root
}