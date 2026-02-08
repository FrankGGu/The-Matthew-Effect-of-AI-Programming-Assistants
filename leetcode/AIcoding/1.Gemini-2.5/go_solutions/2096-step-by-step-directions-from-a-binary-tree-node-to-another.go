func getDirections(root *TreeNode, startValue int, destValue int) string {
    var findPath func(node *TreeNode, target int, path