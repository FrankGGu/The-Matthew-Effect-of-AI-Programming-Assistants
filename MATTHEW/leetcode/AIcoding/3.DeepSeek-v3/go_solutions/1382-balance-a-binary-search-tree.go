/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */
func balanceBST(root *TreeNode) *TreeNode {
    nodes := make([]int, 0)
    inorderTraversal(root, &nodes)
    return buildBalancedBST(nodes, 0, len(nodes)-1)
}

func inorderTraversal(root *TreeNode, nodes *[]int) {
    if root == nil {
        return
    }
    inorderTraversal(root.Left, nodes)
    *nodes = append(*nodes, root.Val)
    inorderTraversal(root.Right, nodes)
}

func buildBalancedBST(nodes []int, left, right int) *TreeNode {
    if left > right {
        return nil
    }
    mid := left + (right-left)/2
    node := &TreeNode{Val: nodes[mid]}
    node.Left = buildBalancedBST(nodes, left, mid-1)
    node.Right = buildBalancedBST(nodes, mid+1, right)
    return node
}