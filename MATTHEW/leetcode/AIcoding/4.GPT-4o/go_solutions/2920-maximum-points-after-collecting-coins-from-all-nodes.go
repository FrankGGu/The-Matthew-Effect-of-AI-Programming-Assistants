type TreeNode struct {
    Val   int
    Left  *TreeNode
    Right *TreeNode
}

func collectCoins(root *TreeNode) int {
    if root == nil {
        return 0
    }

    leftCoins := collectCoins(root.Left)
    rightCoins := collectCoins(root.Right)

    totalCoins := leftCoins + rightCoins + root.Val

    if root.Val > 0 {
        return totalCoins
    }
    return 0
}

func maxPoints(root *TreeNode) int {
    if root == nil {
        return 0
    }

    return collectCoins(root)
}