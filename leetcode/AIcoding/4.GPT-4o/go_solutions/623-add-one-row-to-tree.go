/**
 * Definition for a binary tree node.
 */
type TreeNode struct {
    Val   int
    Left  *TreeNode
    Right *TreeNode
}

func addOneRow(root *TreeNode, val int, depth int) *TreeNode {
    if depth == 1 {
        return &TreeNode{Val: val, Left: root}
    }
    addRow(root, val, depth-1)
    return root
}

func addRow(node *TreeNode, val int, depth int) {
    if node == nil {
        return
    }
    if depth == 1 {
        node.Left = &TreeNode{Val: val, Left: node.Left}
        node.Right = &TreeNode{Val: val, Right: node.Right}
    } else {
        addRow(node.Left, val, depth-1)
        addRow(node.Right, val, depth-1)
    }
}