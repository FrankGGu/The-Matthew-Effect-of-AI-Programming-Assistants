/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */

func treeQueries(root *TreeNode, queries []int) []int {
    depth := make(map[int]int)
    height := make(map[int]int)
    var dfs func(node *TreeNode, d int) int
    dfs = func(node *TreeNode, d int) int {
        if node == nil {
            return 0
        }
        depth[node.Val] = d
        left := dfs(node.Left, d+1)
        right := dfs(node.Right, d+1)
        h := max(left, right) + 1
        height[node.Val] = h
        return h
    }
    dfs(root, 0)

    cousins := make(map[int][]int)
    for val, d := range depth {
        cousins[d] = append(cousins[d], val)
    }

    for d := range cousins {
        sort.Slice(cousins[d], func(i, j int) bool {
            return height[cousins[d][i]] > height[cousins[d][j]]
        })
    }

    res := make([]int, len(queries))
    for i, q := range queries {
        d := depth[q]
        if len(cousins[d]) == 1 {
            res[i] = d - 1
        } else {
            if cousins[d][0] == q {
                res[i] = d + height[cousins[d][1]] - 1
            } else {
                res[i] = d + height[cousins[d][0]] - 1
            }
        }
    }
    return res
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}