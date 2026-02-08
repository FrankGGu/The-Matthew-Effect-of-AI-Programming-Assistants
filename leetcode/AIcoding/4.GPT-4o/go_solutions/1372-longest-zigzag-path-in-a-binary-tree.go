/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val   int
 *     Left  *TreeNode
 *     Right *TreeNode
 * }
 */

func longestZigZag(root *TreeNode) int {
    maxLength := 0

    var dfs func(node *TreeNode, isLeft bool, length int)
    dfs = func(node *TreeNode, isLeft bool, length int) {
        if node == nil {
            return
        }
        maxLength = max(maxLength, length)
        if isLeft {
            dfs(node.Left, false, length+1)
            dfs(node.Right, true, 1)
        } else {
            dfs(node.Right, true, length+1)
            dfs(node.Left, false, 1)
        }
    }

    dfs(root, true, 0)
    dfs(root, false, 0)

    return maxLength
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}