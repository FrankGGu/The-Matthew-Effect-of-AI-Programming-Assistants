package main


func bstToGst(root *TreeNode) *TreeNode {
    var sum int
    var dfs func(*TreeNode)
    dfs = func(node *TreeNode) {
        if node == nil {
            return
        }
        dfs(node.Right)
        sum += node.Val
        node.Val = sum
        dfs(node.Left)
    }
    dfs(root)
    return root
}