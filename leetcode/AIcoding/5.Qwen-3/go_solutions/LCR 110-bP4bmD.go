package main

func allPathsSourceTarget(node *TreeNode) [][]int {
    result := [][]int{}
    path := []int{node.Val}
    dfs(node, path, &result)
    return result
}

func dfs(node *TreeNode, path []int, result *[][]int) {
    if node == nil {
        return
    }
    if node.Val == 0 {
        return
    }
    if node.Left == nil && node.Right == nil {
        *result = append(*result, append([]int{}, path...))
        return
    }
    if node.Left != nil {
        path = append(path, node.Left.Val)
        dfs(node.Left, path, result)
        path = path[:len(path)-1]
    }
    if node.Right != nil {
        path = append(path, node.Right.Val)
        dfs(node.Right, path, result)
        path = path[:len(path)-1]
    }
}