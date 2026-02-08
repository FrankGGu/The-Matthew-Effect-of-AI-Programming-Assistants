package main


func maxProduct(root *TreeNode) int {
    total := 0
    var dfs func(*TreeNode) int
    dfs = func(node *TreeNode) int {
        if node == nil {
            return 0
        }
        left := dfs(node.Left)
        right := dfs(node.Right)
        total += node.Val + left + right
        return node.Val + left + right
    }
    dfs(root)

    maxProd := 0
    var helper func(*TreeNode) int
    helper = func(node *TreeNode) int {
        if node == nil {
            return 0
        }
        left := helper(node.Left)
        right := helper(node.Right)
        current := node.Val + left + right
        prod := current * (total - current)
        if prod > maxProd {
            maxProd = prod
        }
        return current
    }
    helper(root)

    return maxProd
}