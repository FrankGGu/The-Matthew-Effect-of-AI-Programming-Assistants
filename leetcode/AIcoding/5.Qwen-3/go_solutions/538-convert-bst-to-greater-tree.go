package main

type TreeNode struct {
    Val   int
    Left  *TreeNode
    Right *TreeNode
}

func convertBST(root *TreeNode) *TreeNode {
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