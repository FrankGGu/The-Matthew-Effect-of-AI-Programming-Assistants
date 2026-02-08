package main

func countPaths(root *TreeNode, k int) int {
    var result int
    path := make([]int, 0)

    var dfs func(node *TreeNode)
    dfs = func(node *TreeNode) {
        if node == nil {
            return
        }
        path = append(path, node.Val)
        currentXOR := 0
        for i := len(path) - 1; i >= 0; i-- {
            currentXOR ^= path[i]
            if currentXOR == k {
                result++
            }
        }
        dfs(node.Left)
        dfs(node.Right)
        path = path[:len(path)-1]
    }

    dfs(root)
    return result
}