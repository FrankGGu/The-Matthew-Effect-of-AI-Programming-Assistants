/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */
func allPossibleFBT(n int) []*TreeNode {
    if n%2 == 0 {
        return []*TreeNode{}
    }
    memo := make(map[int][]*TreeNode)
    return helper(n, memo)
}

func helper(n int, memo map[int][]*TreeNode) []*TreeNode {
    if res, ok := memo[n]; ok {
        return res
    }
    if n == 1 {
        node := &TreeNode{Val: 0}
        return []*TreeNode{node}
    }
    res := []*TreeNode{}
    for i := 1; i < n; i += 2 {
        left := helper(i, memo)
        right := helper(n-1-i, memo)
        for _, l := range left {
            for _, r := range right {
                root := &TreeNode{Val: 0, Left: l, Right: r}
                res = append(res, root)
            }
        }
    }
    memo[n] = res
    return res
}