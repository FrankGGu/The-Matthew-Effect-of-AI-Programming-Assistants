func findBottomLeftValue(root *TreeNode) int {
    if root == nil {
        return 0 
    }

    queue := []*TreeNode{root}