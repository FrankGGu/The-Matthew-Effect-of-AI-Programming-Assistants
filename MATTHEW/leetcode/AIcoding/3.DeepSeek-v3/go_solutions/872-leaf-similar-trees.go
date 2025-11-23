/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */
func leafSimilar(root1 *TreeNode, root2 *TreeNode) bool {
    var leaves1, leaves2 []int
    getLeaves(root1, &leaves1)
    getLeaves(root2, &leaves2)
    if len(leaves1) != len(leaves2) {
        return false
    }
    for i := 0; i < len(leaves1); i++ {
        if leaves1[i] != leaves2[i] {
            return false
        }
    }
    return true
}

func getLeaves(node *TreeNode, leaves *[]int) {
    if node == nil {
        return
    }
    if node.Left == nil && node.Right == nil {
        *leaves = append(*leaves, node.Val)
        return
    }
    getLeaves(node.Left, leaves)
    getLeaves(node.Right, leaves)
}