type TreeNode struct {
    Val   int
    Left  *TreeNode
    Right *TreeNode
}

func maxSum(root *TreeNode) int {
    if root == nil {
        return 0
    }
    leftSum := maxSum(root.Left)
    rightSum := maxSum(root.Right)
    return root.Val + max(leftSum, rightSum)
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}