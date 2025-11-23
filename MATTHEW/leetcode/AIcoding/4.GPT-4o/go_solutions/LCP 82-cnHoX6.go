type TreeNode struct {
    Val   int
    Left  *TreeNode
    Right *TreeNode
}

func findTilt(root *TreeNode) int {
    totalTilt := 0

    var helper func(node *TreeNode) int
    helper = func(node *TreeNode) int {
        if node == nil {
            return 0
        }
        leftSum := helper(node.Left)
        rightSum := helper(node.Right)
        totalTilt += abs(leftSum - rightSum)
        return leftSum + rightSum + node.Val
    }

    helper(root)
    return totalTilt
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}