func isEvenOddTree(root *TreeNode) bool {
    if root == nil {
        return true
    }

    queue := []*TreeNode{root}