/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */
func widthOfBinaryTree(root *TreeNode) int {
    if root == nil {
        return 0
    }

    queue := []struct{
        node *TreeNode
        idx  int
    }{{root, 0}}

    maxWidth := 0

    for len(queue) > 0 {
        levelSize := len(queue)
        left := queue[0].idx
        right := queue[levelSize-1].idx
        currentWidth := right - left + 1
        if currentWidth > maxWidth {
            maxWidth = currentWidth
        }

        for i := 0; i < levelSize; i++ {
            item := queue[0]
            queue = queue[1:]

            if item.node.Left != nil {
                queue = append(queue, struct{
                    node *TreeNode
                    idx  int
                }{item.node.Left, 2 * item.idx})
            }
            if item.node.Right != nil {
                queue = append(queue, struct{
                    node *TreeNode
                    idx  int
                }{item.node.Right, 2 * item.idx + 1})
            }
        }
    }

    return maxWidth
}