package main


func numberOfGoodLeafNodesPairs(root *TreeNode) int {
    count := 0
    var dfs func(*TreeNode) []int
    dfs = func(node *TreeNode) []int {
        if node == nil {
            return []int{}
        }
        if node.Left == nil && node.Right == nil {
            return []int{1}
        }
        left := dfs(node.Left)
        right := dfs(node.Right)
        for _, l := range left {
            for _, r := range right {
                if l+r <= 2 {
                    count++
                }
            }
        }
        result := make([]int, 0, len(left)+len(right))
        for _, v := range left {
            result = append(result, v+1)
        }
        for _, v := range right {
            result = append(result, v+1)
        }
        return result
    }
    dfs(root)
    return count
}