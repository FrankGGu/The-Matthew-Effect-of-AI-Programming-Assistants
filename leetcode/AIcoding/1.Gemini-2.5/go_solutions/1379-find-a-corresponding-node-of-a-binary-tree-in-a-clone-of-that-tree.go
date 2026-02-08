func getTargetCopy(original, cloned, target *TreeNode) *TreeNode {
    if original == nil {
        return nil
    }

    if original == target {
        return cloned
    }

    leftResult := getTargetCopy(original.Left, cloned.Left, target)
    if leftResult != nil {
        return leftResult
    }

    return getTargetCopy(original.Right, cloned.Right, target)
}