/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */
func findMode(root *TreeNode) []int {
    var (
        currentVal int
        currentCount int
        maxCount int
        result []int
    )

    var inorder func(*TreeNode)
    inorder = func(node *TreeNode) {
        if node == nil {
            return
        }
        inorder(node.Left)

        if node.Val == currentVal {
            currentCount++
        } else {
            currentVal = node.Val
            currentCount = 1
        }

        if currentCount > maxCount {
            maxCount = currentCount
            result = []int{currentVal}
        } else if currentCount == maxCount {
            result = append(result, currentVal)
        }

        inorder(node.Right)
    }

    inorder(root)
    return result
}