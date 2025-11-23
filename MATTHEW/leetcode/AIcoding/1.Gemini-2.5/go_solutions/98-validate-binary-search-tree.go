import "math"

func isValidBST(root *TreeNode) bool {
    return validate(root, math.MinInt64, math.MaxInt64)
}

func validate(node *TreeNode, lowerBound, upperBound int64) bool {
    if node == nil {
        return true
    }

    if int64(node.Val) <= lowerBound || int64(node.Val) >= upperBound {
        return false
    }

    return validate(node.Left, lowerBound, int64(node.Val)) &&
           validate(node.Right, int64(node.Val), upperBound)
}