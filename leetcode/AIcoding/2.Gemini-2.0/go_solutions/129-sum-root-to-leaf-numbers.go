func sumNumbers(root *TreeNode) int {
    var sum int
    var dfs func(*TreeNode, int)

    dfs = func(node *TreeNode, num int) {
        if node == nil {
            return
        }

        num = num*10 + node.Val

        if node.Left == nil && node.Right == nil {
            sum += num
            return
        }

        dfs(node.Left, num)
        dfs(node.Right, num)
    }

    dfs(root, 0)
    return sum
}