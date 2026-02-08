/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */
func leafSimilar(root1 *TreeNode, root2 *TreeNode) bool {
    leaves1 := getLeaves(root1)
    leaves2 := getLeaves(root2)
    if len(leaves1) != len(leaves2) {
        return false
    }
    for i := range leaves1 {
        if leaves1[i] != leaves2[i] {
            return false
        }
    }
    return true
}

func getLeaves(root *TreeNode) []int {
    var leaves []int
    var dfs func(node *TreeNode)
    dfs = func(node *TreeNode) {
        if node == nil {
            return
        }
        if node.Left == nil && node.Right == nil {
            leaves = append(leaves, node.Val)
        }
        dfs(node.Left)
        dfs(node.Right)
    }
    dfs(root)
    return leaves
}