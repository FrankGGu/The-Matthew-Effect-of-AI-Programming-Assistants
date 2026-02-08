package main


func pathSum(root *TreeNode, targetSum int) [][]int {
    result := [][]int{}
    path := []int{}

    var dfs func(*TreeNode, int)
    dfs = func(node *TreeNode, remaining int) {
        if node == nil {
            return
        }
        path = append(path, node.Val)
        remaining -= node.Val
        if node.Left == nil && node.Right == nil && remaining == 0 {
            copyPath := make([]int, len(path))
            copy(copyPath, path)
            result = append(result, copyPath)
        }
        dfs(node.Left, remaining)
        dfs(node.Right, remaining)
        path = path[:len(path)-1]
    }

    dfs(root, targetSum)
    return result
}