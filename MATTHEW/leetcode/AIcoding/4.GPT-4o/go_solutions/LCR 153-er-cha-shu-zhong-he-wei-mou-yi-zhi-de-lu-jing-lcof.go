/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */

func pathSum(root *TreeNode, sum int) [][]int {
    var res [][]int
    var path []int

    var backtrack func(node *TreeNode, sum int)
    backtrack = func(node *TreeNode, sum int) {
        if node == nil {
            return
        }
        path = append(path, node.Val)
        sum -= node.Val
        if node.Left == nil && node.Right == nil && sum == 0 {
            res = append(res, append([]int{}, path...))
        }
        backtrack(node.Left, sum)
        backtrack(node.Right, sum)
        path = path[:len(path)-1]
    }

    backtrack(root, sum)
    return res
}