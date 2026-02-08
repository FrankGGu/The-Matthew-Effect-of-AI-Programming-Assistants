func findTargetNode(root *TreeNode, target int) *TreeNode {
    curr := root
    for curr != nil {
        if curr.Val == target {
            return curr
        } else if curr.Val < target {
            curr = curr.Right
        } else { // curr.Val > target
            curr = curr.Left
        }
    }
    return nil // Target not found
}