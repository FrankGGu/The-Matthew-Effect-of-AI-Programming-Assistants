func countPairs(root *TreeNode, distance int) int {
    ans := 0
    var dfs func(node *TreeNode) []int
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
                if l+r <= distance {
                    ans++
                }
            }
        }
        res := []int{}
        for _, l := range left {
            if l+1 <= distance {
                res = append(res, l+1)
            }
        }
        for _, r := range right {
            if r+1 <= distance {
                res = append(res, r+1)
            }
        }
        return res
    }
    dfs(root)
    return ans
}