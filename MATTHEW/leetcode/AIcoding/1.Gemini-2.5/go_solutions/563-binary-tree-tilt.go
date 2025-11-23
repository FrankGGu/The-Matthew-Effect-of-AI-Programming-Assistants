func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}

func findTilt(root *TreeNode) int {
    var totalTilt int
    calculateSubtreeSumAndTilt(root, &totalTilt)
    return totalTilt
}

func calculateSubtreeSumAndTilt(node *TreeNode, totalTilt *int) int {
    if node == nil {
        return 0
    }

    leftSum := calculateSubtreeSumAndTilt(node.Left, totalTilt)
    rightSum := calculateSubtreeSumAndTilt(node.Right, totalTilt)

    currentTilt := abs(leftSum - rightSum)
    *totalTilt += currentTilt

    return node.Val + leftSum + rightSum
}