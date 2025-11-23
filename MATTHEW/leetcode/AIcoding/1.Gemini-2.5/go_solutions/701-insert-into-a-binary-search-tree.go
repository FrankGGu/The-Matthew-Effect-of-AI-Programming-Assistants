func insertIntoBST(root *TreeNode, val int) *TreeNode {
    if root == nil {
        return &TreeNode{Val: val}
    }

    if val < root.Val {
        root.Left = insertIntoBST(root.Left, val)
    } else {
        // According to the problem statement, it is guaranteed that val does not exist in the original BST.
        // Therefore, val must be greater than root.Val if it's