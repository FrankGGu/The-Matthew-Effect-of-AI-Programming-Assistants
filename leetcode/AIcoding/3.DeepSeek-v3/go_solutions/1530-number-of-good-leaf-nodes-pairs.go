/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */
func countPairs(root *TreeNode, distance int) int {
    res := 0
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
                if l + r <= distance {
                    res++
                }
            }
        }
        ret := []int{}
        for _, l := range left {
            if l + 1 <= distance {
                ret = append(ret, l + 1)
            }
        }
        for _, r := range right {
            if r + 1 <= distance {
                ret = append(ret, r + 1)
            }
        }
        return ret
    }
    dfs(root)
    return res
}